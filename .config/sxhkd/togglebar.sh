#!/bin/sh

#polybar="$(pgrep polybar)"

#if [ "$(bspc config top_padding)" == "36" ]
if pidof polybar;
then
	killall polybar
	bspc config top_padding -4
else
	bspc config top_padding 36
	~/.config/polybar/launch.sh
fi
