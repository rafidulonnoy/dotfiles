#!/bin/bash
case "${1}" in
    post)
        systemctl --user restart dunst.service
        dbus-update-activation-environment --all
        ;;
esac
