#!/bin/bash
# Directories (adjust as needed)
WALLPAPER_DIR="$HOME/wallpaper"
THUMB_DIR="$HOME/.cache/wofi-thumbs"
THUMB_SIZE="600x300"  # You can change this to your desired thumbnail dimensions

# Create the thumbnail directory if it doesn't exist
mkdir -p "$THUMB_DIR"

# Loop through common image files in your wallpaper directory
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,gif}; do
    # Skip if no file matches the pattern
    [ -e "$img" ] || continue

    thumb="$THUMB_DIR/$(basename "$img")"
    # If the thumbnail doesn't exist or the image is newer than the thumbnail, create/update it
    if [ ! -f "$thumb" ] || [ "$img" -nt "$thumb" ]; then
        echo "Generating thumbnail for $(basename "$img")"
        magick convert "$img" -resize "$THUMB_SIZE" "$thumb"
    fi
done
