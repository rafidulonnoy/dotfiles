#!/bin/bash
WALLPAPER_DIR="$HOME/wallpaper"
THUMB_DIR="$HOME/.cache/wofi-thumbs"
THUMB_SIZE="300x300"

mkdir -p "$THUMB_DIR"

# Run the thumbnail generation once at start
~/.config/wofi/scripts/generate_thumbnails.sh

# Use inotifywait to watch for new files, modifications, or deletions
inotifywait -m -e create -e modify -e delete "$WALLPAPER_DIR" | while read -r directory events filename; do
    echo "Change detected: $events on $filename. Regenerating thumbnails..."
    ~/.config/wofi/scripts/generate_thumbnails.sh
done
