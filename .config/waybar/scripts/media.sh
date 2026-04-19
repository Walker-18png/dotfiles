#!/bin/bash
player="spotify"

status=$(playerctl -p $player status 2>/dev/null)
if [ -z "$status" ]; then
    echo '{"text": "", "class": "stopped"}'
    exit 0
fi

artist=$(playerctl -p $player metadata artist 2>/dev/null)
title=$(playerctl -p $player metadata title 2>/dev/null)

# Truncate long strings
max=30
if [ ${#title} -gt $max ]; then title="${title:0:$max}…"; fi
if [ ${#artist} -gt 20 ]; then artist="${artist:0:20}…"; fi

if [ "$status" = "Playing" ]; then
    class="playing"
else
    class="paused"
fi

text="$artist — $title"
tooltip="$artist\n$title"

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
