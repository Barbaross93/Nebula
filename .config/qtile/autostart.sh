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
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
dunst &
xbanish &
blueberry-tray &
greenclip daemon &
light-locker &
xidlehook --not-when-fullscreen --not-when-audio --timer 420 'screensaver' '' --timer 180 'light-locker-command -l' '' &
flashfocus &
mkfifo /tmp/vol && echo "$(pulsemixer --get-volume | awk '{print $1}')" > /tmp/vol & 
mkfifo /tmp/vol-icon && ~/.config/qtile/eww_vol_icon.sh &
redshift-gtk -l 39.2904:-76.6122 &
edges --bottom eww_mouse.sh &
~/.config/eww/scripts/getweather &
barriers --disable-client-cert-checking
#feh-blur --darken 0 -b 6 &
eww daemon
picom --experimental-backends &
#default_startup.sh &
