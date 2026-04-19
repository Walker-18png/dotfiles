#!/bin/bash
art_path="/tmp/waybar-album-art"
url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)

if [ -z "$url" ]; then
    rm -f "$art_path"
    echo ""
    exit 0
fi

# Only re-download if the URL changed
url_cache="/tmp/waybar-album-art-url"
prev_url=$(cat "$url_cache" 2>/dev/null)

if [ "$url" != "$prev_url" ] || [ ! -f "$art_path" ]; then
    curl -sL "$url" -o "$art_path" 2>/dev/null
    echo "$url" > "$url_cache"
fi

echo "$art_path"
