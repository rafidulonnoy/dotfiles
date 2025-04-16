#!/bin/bash

case "$1" in
    volume)
        # Get numeric volume percentage (0-100)
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -n 1 | tr -d '%')
        MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        
        # Determine icon based on volume level/mute
        if [[ "$MUTED" == "yes" ]]; then
            ICON=$HOME/.config/dunst/icons/vol/muted-speaker.svg
            TEXT="Muted"
        else
            if [ "$VOLUME" -eq 0 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-0.svg
            elif [ "$VOLUME" -le 5 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-5.svg
            elif [ "$VOLUME" -le 10 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-10.svg
            elif [ "$VOLUME" -le 15 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-15.svg
            elif [ "$VOLUME" -le 20 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-20.svg
            elif [ "$VOLUME" -le 25 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-25.svg
            elif [ "$VOLUME" -le 30 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-30.svg
            elif [ "$VOLUME" -le 35 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-35.svg
            elif [ "$VOLUME" -le 40 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-40.svg
            elif [ "$VOLUME" -le 45 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-45.svg
            elif [ "$VOLUME" -le 50 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-50.svg
            elif [ "$VOLUME" -le 55 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-55.svg
            elif [ "$VOLUME" -le 60 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-60.svg
            elif [ "$VOLUME" -le 65 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-65.svg
            elif [ "$VOLUME" -le 70 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-70.svg
            elif [ "$VOLUME" -le 75 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-75.svg
            elif [ "$VOLUME" -le 80 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-80.svg
            elif [ "$VOLUME" -le 85 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-85.svg
            elif [ "$VOLUME" -le 90 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-90.svg
            elif [ "$VOLUME" -le 95 ]; then
                ICON=$HOME/.config/dunst/icons/vol/vol-95.svg
            else
                ICON=$HOME/.config/dunst/icons/vol/vol-100.svg
            fi
            TEXT="Volume: ${VOLUME}%"
        fi

        # Send notification with icon
        notify-send -a "volume" \
                    -h string:x-dunst-stack-tag:volume \
                    -i "$ICON" \
                    "$TEXT"
        ;;
    brightness)
        BRIGHTNESS=$(brightnessctl get)
        MAX_BRIGHTNESS=$(brightnessctl max)
        PERCENT=$(( 100 * BRIGHTNESS / MAX_BRIGHTNESS ))
        notify-send -a "brightness" -h string:x-dunst-stack-tag:brightness "󰃟  Brightness: $PERCENT%"
        ;;
esac
