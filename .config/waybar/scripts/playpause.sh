#!/bin/bash
status=$(playerctl -p spotify status 2>/dev/null)
if [ -z "$status" ]; then
    echo '{"text": "󰐊", "class": "stopped", "tooltip": "Open Spotify"}'
elif [ "$status" = "Playing" ]; then
    echo '{"text": "󰏤", "class": "playing", "tooltip": "Pause"}'
else
    echo '{"text": "󰐊", "class": "paused", "tooltip": "Play"}'
fi
