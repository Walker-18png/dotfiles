#!/bin/bash
if pgrep -x wlogout > /dev/null; then
    pkill -x wlogout
    exit
fi

# Rescue any non-Spotify windows from special:spotify
hyprctl clients -j | python3 -c "
import sys, json, subprocess
active = json.loads(subprocess.check_output(['hyprctl', 'activeworkspace', '-j']))['id']
for c in json.load(sys.stdin):
    if c['workspace']['name'] == 'special:spotify' and c['class'] != 'Spotify':
        subprocess.run(['hyprctl', 'dispatch', 'movetoworkspace', f\"{active},address:{c['address']}\"])
"

focused=$(hyprctl activewindow -j 2>/dev/null | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('address', ''))
except:
    pass
" 2>/dev/null)

wlogout \
    -C ~/.config/wlogout/style.css \
    -l ~/.config/wlogout/layout \
    -b 3 -c 20 -r 20 \
    -L 1550 -R 1550 -T 820 -B 820 \
    -n --protocol layer-shell

if [ -n "$focused" ]; then
    hyprctl dispatch focuswindow "address:$focused" 2>/dev/null
fi
