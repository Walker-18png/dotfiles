#!/bin/bash
addr=$(hyprctl clients -j | python3 -c "
import sys, json
for c in json.load(sys.stdin):
    if c['class'] == 'Spotify':
        print(c['address'])
        break
")

if [ -z "$addr" ]; then
    spotify &
    exit
fi

spotify_ws=$(hyprctl clients -j | python3 -c "
import sys, json
for c in json.load(sys.stdin):
    if c['class'] == 'Spotify':
        print(c['workspace']['name'])
        break
")

if [[ "$spotify_ws" == special:* ]]; then
    active=$(python3 -c "
import json, subprocess
monitors = json.loads(subprocess.check_output(['hyprctl', 'monitors', '-j']))
for m in monitors:
    if m['name'] == 'DP-1':
        ws_id = m['activeWorkspace']['id']
        if ws_id > 0:
            print(ws_id)
            exit()
# fallback: find any non-special workspace on DP-1
workspaces = json.loads(subprocess.check_output(['hyprctl', 'workspaces', '-j']))
for w in workspaces:
    if w['monitor'] == 'DP-1' and w['id'] > 0:
        print(w['id'])
        exit()
print(1)
")
    hyprctl dispatch movetoworkspace "$active,address:$addr"
else
    hyprctl dispatch movetoworkspacesilent "special:spotify,address:$addr"
fi
