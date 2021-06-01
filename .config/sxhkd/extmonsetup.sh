#!/bin/sh

intern=eDP1
extern=VIRTUAL1

if pidof intel-virtual-output; then
    xrandr --output "$extern" --off --output "$intern" --auto
    pkill intel-virtual-o
    bspc monitor "$extern" --remove
    bspc monitor "$intern" -d          
    bspc wm -o
    ./.config/polybar/launch.sh
else
    intel-virtual-output;
    wait
    xrandr --output "$intern" --primary --auto --rotate normal --output "$extern" --auto --rotate normal --right-of "$intern"
    DISPLAY=:8 xset s 420 179
    bspc monitor "$intern" -d          
    bspc monitor "$extern" -d          
    ./.config/polybar/launch.sh
    systemctl restart clightd.service
fi
