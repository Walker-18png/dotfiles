#!/bin/bash
addr=$(hyprctl activewindow -j | python3 -c "import sys,json; print(json.load(sys.stdin)['address'])")
state_file="/tmp/hypr-opaque-$addr"

if [ -f "$state_file" ]; then
    hyprctl dispatch setprop address:$addr opaque 0
    rm "$state_file"
else
    hyprctl dispatch setprop address:$addr opaque 1
    touch "$state_file"
fi
