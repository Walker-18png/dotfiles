#!/bin/bash
monitor=$(hyprctl activeworkspace -j | python3 -c "import sys,json; print(json.load(sys.stdin)['monitor'])")
if [ "$monitor" = "DP-1" ]; then
    theme="lofi-dp1"
else
    theme="lofi"
fi

current=$(grep '^theme' ~/.config/walker/config.toml | cut -d'"' -f2)

if [ "$current" != "$theme" ]; then
    sed -i "s/^theme = .*/theme = \"$theme\"/" ~/.config/walker/config.toml
    pkill -x walker
    sleep 0.2
    walker --gapplication-service &
    sleep 0.3
fi

walker
