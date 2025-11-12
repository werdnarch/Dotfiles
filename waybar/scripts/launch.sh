#!/bin/bash
CONFIG_DIR="$HOME/.config/waybar"

# initial launch
pkill -x waybar
waybar &

# auto-reload on save
inotifywait -m -e close_write "$CONFIG_DIR" |
while read -r path action file; do
    if [[ "$file" =~ ^(config\.jsonc|style\.css)$ ]]; then
        pkill -x waybar
        waybar &
    fi
done

