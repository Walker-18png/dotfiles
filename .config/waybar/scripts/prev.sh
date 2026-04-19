#!/bin/bash
status=$(playerctl -p spotify status 2>/dev/null)
if [ -z "$status" ]; then
    echo '{"text": "", "class": "stopped"}'
elif [ "$status" = "Playing" ]; then
    echo '{"text": "󰒮", "class": "playing"}'
else
    echo '{"text": "󰒮", "class": "paused"}'
fi
