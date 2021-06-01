#!/bin/sh

settings="/tmp/current_clight_settings.txt"
dimmerInhibited=$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight Inhibited | awk '{print $2}')

if [ -e $settings ]; then
	notify-send -u normal "Deactivate Movie Mode first"
	exit
fi

if [[ "$dimmerInhibited" == "false" ]]; then
	busctl --expect-reply=false --user call org.clight.clight /org/clight/clight org.clight.clight Inhibit "b" true && notify-send -u normal "Screen dimmer paused"
elif [[ "$dimmerInhibited" == "true" ]]; then
	busctl --expect-reply=false --user call org.clight.clight /org/clight/clight org.clight.clight Inhibit "b" false && notify-send -u normal "Screen dimmer resumed"
else
	notify-send -u normal "Something borked"
fi
