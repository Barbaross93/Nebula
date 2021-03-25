#!/usr/bin/env bash
set -euo pipefail

## Non-qtile specific settings
#xset s 600 0
xset s 0 0
xset dpms 0 0 0
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
bluetoothctl power off &
#blueberry-tray &
greenclip daemon &
#idle.sh 7 screensaver &
#light-locker --lock-after-screensaver=0 --no-lock-on-suspend --no-lock-on-lid --no-idle-hint &
xidlehook --not-when-fullscreen --not-when-audio --timer 420 'screensaver' '' --timer 180 'xset dpms force off; lockscreen.sh' '' &
syncthing -no-browser &
synergys &
autoadb scrcpy -s '{}' &
an2linuxserver.py &
flashfocus &
mkfifo /tmp/vol && echo "$(pulsemixer --get-volume | awk '{print $1}')" > /tmp/vol & 
mkfifo /tmp/vol-icon && ~/.config/qtile/eww_vol_icon.sh mute &
redshift-gtk -l 39.2904:-76.6122 &
lead &
#udiskie &
gitwatch -r pi@192.168.0.18:/mnt/fd1/repos/tower-dotfiles /home/barbarossa/Public/tower-dotfiles &
feh-blur --darken 0 -b 6 &
eww daemon
sleep 2
eww open border &
eww open border1 &
eww open border2 &
#blurwal --backend feh -m 1 -b 30 -s 15 &
