#!/usr/bin/env bash
set -euo pipefail

playerctld daemon
blueberry-tray &
greenclip daemon &
mkfifo /tmp/vol && echo "$(pulsemixer --get-volume | awk '{print $1}')" > /tmp/vol &
mkfifo /tmp/vol-icon && ~/.config/qtile/eww_vol_icon.sh &
~/.config/eww/scripts/getweather &
#default_startup.sh &
