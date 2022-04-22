#!/usr/bin/env bash

xwininfo -tree -id $(xdotool getmouselocation --shell | grep WINDOW | cut -d'=' -f2) | grep xwininfo | grep "(the root window)" && jgmenu

#bspc query -N -n pointed > /dev/null || jgmenu
