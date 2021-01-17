#!/usr/bin/env bash
#set -euo pipefail

if pgrep conky; then
    pkill conky
    eww open border &
    eww open border1 &
    eww open border2 &
    ~/.fehbg &
    blurwal --backend feh -m 1 -b 30 &
    qtile cmd-obj -o cmd -f hide_show_bar --args top
else
    pkill blurwal
    eww close-all
    feh --no-fehbg --bg-tile '/home/barbarossa/Pictures/colors/4C566A.png'
    ~/.config/bspwm/cky
    qtile cmd-obj -o cmd -f hide_show_bar --args top
fi
