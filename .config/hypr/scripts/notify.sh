#!/bin/bash

case "$1" in
    volume)
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
        MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
        if [[ "$MUTED" == "yes" ]]; then
            notify-send "󰝟 Muted"
        else
            notify-send "   Volume: $VOLUME"
        fi
        ;;
    brightness)
        BRIGHTNESS=$(brightnessctl get)
        MAX_BRIGHTNESS=$(brightnessctl max)
        PERCENT=$(( 100 * BRIGHTNESS / MAX_BRIGHTNESS ))
        notify-send "󰃟  Brightness: $PERCENT%"
        ;;
esac
