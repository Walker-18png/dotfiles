#!/bin/bash
info=$(hyprctl clients -j | python3 -c "
import sys, json
for c in json.load(sys.stdin):
    if c['class'] == 'org.gnome.Calendar':
        print(c['address'])
        print(c['workspace']['name'])
        break
")

addr=$(echo "$info" | head -1)
ws=$(echo "$info" | tail -1)

if [ -z "$addr" ]; then
    gnome-calendar &
    exit
fi

if [[ "$ws" == special:* ]]; then
    active=$(hyprctl activeworkspace -j | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")
    hyprctl dispatch movetoworkspace "$active,address:$addr"
    sleep 0.1
    hyprctl dispatch movewindowpixel "exact 1930 60,address:$addr"
else
    hyprctl dispatch movetoworkspacesilent "special:calendar,address:$addr"
fi
