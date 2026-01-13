#!/bin/bash

# --- Configuration ---
WALL_DIR="$HOME/wallpapers/" # Change this to your folder
TRANSITION_TYPE="grow"                # options: simple, fade, left, right, top, bottom, wipe, wave, grow, center, any, random
TRANSITION_STEP=255                     # higher = faster transition (1-255)
TRANSITION_FPS=75                     # frame rate
TRANSITION_BEZIER=0.0,0.0,1.0,1.0
TRANSITION_DURATION=1

# Check if swww-daemon is running
if ! swww query > /dev/null 2>&1; then
    swww-daemon &
    sleep 0.5 # Wait for daemon to start
fi

# 1. Get list of images 
# 2. Format for Rofi: "filename\0icon\x1f/path/to/file"
# 3. Use -show-icons to enable thumbnail preview
CHOICE=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) | while read -r img; do
    echo -en "$(basename "$img")\0icon\x1f$img\n"
done | rofi -dmenu -i -p "Wallpaper" -no-config -theme ~/.config/rofi/wallpaper.rasi)

# Exit if no selection was made
[[ -z "$CHOICE" ]] && exit 0

# Set the wallpaper
swww img "$WALL_DIR/$CHOICE" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-step "$TRANSITION_STEP" \
    --transition-fps "$TRANSITION_FPS" \
    --transition-bezier "$TRANSITION_BEZIER" \
    --transition-duration "$TRANSITION_DURATION"
