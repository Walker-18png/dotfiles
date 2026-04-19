#!/usr/bin/env python3
import evdev
import asyncio
import time
import subprocess
import os

DOUBLETAP_MS = 400
last_release = 0

def launch_kitty():
    env = os.environ.copy()
    env.update({
        'HOME': '/home/archlinux',
        'USER': 'archlinux',
        'XDG_RUNTIME_DIR': '/run/user/1000',
        'WAYLAND_DISPLAY': 'wayland-1',
        'DBUS_SESSION_BUS_ADDRESS': 'unix:path=/run/user/1000/bus',
    })
    subprocess.Popen(['kitty'], env=env)

def find_keyboard():
    for path in evdev.list_devices():
        dev = evdev.InputDevice(path)
        if 'Xtrfy' in dev.name and 'Keyboard' in dev.name:
            return dev
    return None

async def main():
    global last_release
    kb = find_keyboard()
    if not kb:
        print("Keyboard not found")
        return

    async for event in kb.async_read_loop():
        if event.type != evdev.ecodes.EV_KEY:
            continue
        key = evdev.categorize(event)
        if key.keycode != 'KEY_RIGHTALT':
            continue
        if key.keystate == evdev.events.KeyEvent.key_up:
            now = time.time() * 1000
            if now - last_release < DOUBLETAP_MS:
                launch_kitty()
                last_release = 0
            else:
                last_release = now

asyncio.run(main())
