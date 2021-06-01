#!/usr/bin/env bash
set -euo pipefail

gap_size=$(bspc config window_gap)

if [ $gap_size -eq 18 ]; then
    bspc config window_gap -3
    pkill polybar
    for side in right top bottom left ; do
        bspc config ${side}_padding 3
    done
    pkill picom;
    sleep 1
    picom --experimental-backends --config ~/.config/picom/focus.conf &
    feh-blur -s
    feh --no-fehbg --bg-tile ~/Pictures/colors/232831.png
    #~/.config/bspwm/cky
    polybar tray &
else
    bspc config window_gap 18
    #pkill conky
    for side in right bottom left ; do
        bspc config ${side}_padding 9
    done
    bspc config top_padding 68
    pkill picom;
    sleep 1
    picom --experimental-backends &
    ~/.fehbg &
    feh-blur --darken 0 -b 6 &
    ~/.config/polybar/launch.sh &
fi
