#!/bin/sh

settings="/tmp/current_clight_settings.txt"
isItNightOrDay="$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight DayTime | awk '{print $2}')"
currentTemp="$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight Temp | awk '{print $2}')"
autoCalibState="$(busctl --user get-property org.clight.clight /org/clight/clight/Conf/Backlight org.clight.clight.Conf.Backlight NoAutoCalib | awk '{print $2}')"
dimmerInhibited="$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight Inhibited | awk '{print $2}')"


save_settings () {
	touch $settings
	echo $isItNightOrDay >> $settings
	echo $currentTemp >> $settings
	echo $autoCalibState >> $settings
	echo $dimmerInhibited >> $settings
}

deactivate_movie_mode () {
	nightOrDay="$(awk 'NR==1' $settings)"
	temp="$(awk 'NR==2' $settings)"
	calibState="$(awk 'NR==3' $settings)"
	dimmer="$(awk 'NR==4' $settings)"
	
	if [[ "$nightOrDay" == "0" ]]; then
		busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma DayTemp "i" $temp
	elif [[ "$nightOrDay" == "1" ]]; then
		busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma NightTemp "i" $temp
	fi

	busctl --expect-reply=false --user set-property org.clight.clight /org/clight/clight/Conf/Backlight org.clight.clight.Conf.Backlight NoAutoCalib "b" $calibState
	busctl --expect-reply=false --user call org.clight.clight /org/clight/clight org.clight.clight Inhibit "b" $dimmer

	rm $settings
}

activate_movie_mode () {
	save_settings
	if [[ "$isItNightOrDay" == "0" && "$currentTemp" == "4000" ]]; then
		busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma DayTemp "i" 6500
	elif [[ "$isItNightOrDay" == "1" && "$currentTemp" == "4000" ]]; then
		busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma NightTemp "i" 6500
	fi

	busctl --expect-reply=false --user set-property org.clight.clight /org/clight/clight/Conf/Backlight org.clight.clight.Conf.Backlight NoAutoCalib "b" true
	busctl --expect-reply=false --user call org.clight.clight /org/clight/clight org.clight.clight Inhibit "b" true
}

if [ -e $settings ]; then
	deactivate_movie_mode
	notify-send -u normal "Movie mode deactivated"
else
	activate_movie_mode
	notify-send -u normal "Movie mode activated"
fi
