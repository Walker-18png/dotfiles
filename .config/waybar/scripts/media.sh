#!/bin/bash
player="spotify"

status=$(playerctl -p $player status 2>/dev/null)
if [ -z "$status" ]; then
    echo '{"text": "", "class": "stopped"}'
    exit 0
fi

title=$(playerctl -p $player metadata title 2>/dev/null)

pos_sec=$(playerctl -p $player position 2>/dev/null | cut -d. -f1)
len_micro=$(playerctl -p $player metadata mpris:length 2>/dev/null)

if [ -z "$pos_sec" ]; then pos_sec=0; fi
if [ -z "$len_micro" ] || [ "$len_micro" -eq 0 ]; then len_micro=1000000; fi
len_sec=$((len_micro / 1000000))

pos_str=$(printf "%02d:%02d" $((pos_sec/60)) $((pos_sec%60)))
len_str=$(printf "%02d:%02d" $((len_sec/60)) $((len_sec%60)))

max=22
if [ ${#title} -gt $max ]; then title="${title:0:$max}…"; fi

if [ "$status" = "Playing" ]; then class="playing"; else class="paused"; fi

artist=$(playerctl -p $player metadata artist 2>/dev/null)
tooltip="$artist — $title"

echo "{\"text\": \"<b>$title</b>  <span color='#4a6a8a'>$pos_str / $len_str</span>\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
