#!/bin/sh

settings="/tmp/current_clight_settings.txt"
autoCalibState=$(busctl --user get-property org.clight.clight /org/clight/clight/Conf/Backlight org.clight.clight.Conf.Backlight NoAutoCalib | awk '{print $2}')

if [ -e $settings ]; then
	notify-send -u normal "Deactivate Movie Mode first"
	exit
fi

if [[ "$autoCalibState" == "false" ]]; then
	 busctl --expect-reply=false --user set-property org.clight.clight /org/clight/clight/Conf/Backlight org.clight.clight.Conf.Backlight NoAutoCalib "b" true && notify-send -u normal "Auto-backlight calibration paused"
 elif [[ "$autoCalibState" == "true" ]]; then
	  busctl --expect-reply=false --user set-property org.clight.clight /org/clight/clight/Conf/Backlight org.clight.clight.Conf.Backlight NoAutoCalib "b" false && notify-send -u normal "Auto-backlight calibration resumed"
  else
	  notify-send -u normal "Something borked"
fi
