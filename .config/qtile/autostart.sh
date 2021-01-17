#!/usr/bin/env bash
set -euo pipefail

#zsh ~/.config/bspwm/killscript; 

#~/.fehbg &

## Non-bspwm specific settings
xset s 600 0
xset r rate 440 50
xset +fp ~/.fonts/misc/  
xsetroot -cursor_name left_ptr &
numlockx &

#~/.config/bspwm/phicom2 --experimental-backends --config ~/.config/bspwm/phicom.conf &
picom --experimental-backends &
#/usr/lib/geoclue-2.0/demos/agent &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
dunst &
unclutter &
#~/.config/bspwm/localserver &
greenclip daemon &
idle.sh 7 screensaver &
light-locker &
syncthing -no-browser &
barriers &
flashfocus &
mkfifo /tmp/vol && echo "$(pulsemixer --get-volume | awk '{print $1}')" > /tmp/vol & 
mkfifo /tmp/vol-icon && ~/.config/qtile/eww_vol_icon.sh mute &
redshift -l 39.2904:-76.6122 &
lead &
eww daemon
sleep 3
eww open border &
eww open border1 &
eww open border2 &
sleep 3 && blurwal --backend feh -m 1 -b 30 -s 15 &
#clight --conf-file=/home/barbarossa/.config/clight.conf &
