#!/bin/bash
status=$(playerctl -p spotify status 2>/dev/null)
if [ -z "$status" ]; then
    spotify &
else
    playerctl -p spotify play-pause
fi
