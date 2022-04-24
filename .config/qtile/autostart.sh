#!/usr/bin/env bash
set -euo pipefail

## Non-qtile specific settings
xset s 0 0
xset dpms 0 0 0
xset r rate 440 50
#xset +fp ~/.fonts/misc/  
#xsetroot -cursor_name left_ptr &
#xclickroot -r jgmenu_run &
numlockx &

playerctld daemon
blueberry-tray &
greenclip daemon &
mkfifo /tmp/vol && echo "$(pulsemixer --get-volume | awk '{print $1}')" > /tmp/vol &
mkfifo /tmp/vol-icon && ~/.config/qtile/eww_vol_icon.sh &
~/.config/eww/scripts/getweather &
#default_startup.sh &
