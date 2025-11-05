#!/usr/bin/env bash
set -euo pipefail

# =========================
# CONFIG — change these
# =========================
# Directory where you keep wallpapers
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/wallpapers}"

# Rofi theme
ROFI_THEME="${ROFI_THEME:-$HOME/.config/rofi/wallpaper.rasi}"

# swww mode (fill, center, fit, crop, tile)
SWWW_MODE="${SWWW_MODE:-fill}"

# rofi options
ROFI_PROMPT="${ROFI_PROMPT:-Wallpaper}"
ROFI_OPTS="${ROFI_OPTS:--dmenu -i -p \"$ROFI_PROMPT\" -theme \"$ROFI_THEME\"}"

# Preview environment variable (used by rofi-previewer)
export PREVIEW=1
# =========================

# Check dependencies
for cmd in rofi swww notify-send; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "$cmd is required but not installed. Install it and try again." >&2
        exit 1
    fi
done

# Gather wallpaper files
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort)

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Wallpaper-Rofi" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Build menu (basename only)
MENU=()
for f in "${WALLPAPERS[@]}"; do
    MENU+=("$(basename "$f")")
done

# Show rofi and get selection
CHOSEN="$(printf '%s\n' "${MENU[@]}" | eval "rofi $ROFI_OPTS")"
[ -z "${CHOSEN:-}" ] && exit 0

# Find full path of chosen wallpaper
SEL=""
for i in "${!MENU[@]}"; do
    if [ "${MENU[$i]}" = "$CHOSEN" ]; then
        SEL="${WALLPAPERS[$i]}"
        break
    fi
done

if [ -z "$SEL" ]; then
    notify-send "Wallpaper-Rofi" "Selection not found!"
    exit 1
fi

# Set wallpaper with swww
swww img "$SEL" --mode "$SWWW_MODE" --transition-type fade --transition-duration 1.0

notify-send "Wallpaper changed" "$(basename "$SEL")"
