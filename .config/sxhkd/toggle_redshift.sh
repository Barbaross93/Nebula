#1/bin/sh

settings="/tmp/current_clight_settings.txt"
isItNightOrDay=$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight DayTime | awk '{print $2}')
currentTemp=$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight Temp | awk '{print $2}')

on() {
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.97107439:0.94305985 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.93853986:0.88130458 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.90198230:0.81465502 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.86860704:0.73688797 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.82854786:0.64816570 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.77987699:0.54642268 &> /dev/null
}

off() {
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.82854786:0.64816570 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.86860704:0.73688797 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.90198230:0.81465502 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.93853986:0.88130458 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.97107439:0.94305985 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1:1:1 &> /dev/null
}

if [ -e $settings ]; then
	notify-send -u normal "Deactivate Movie Mode first"
	exit
fi

if [[ "$isItNightOrDay" == "0" && "$currentTemp" == "6500" ]]; then
	busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma DayTemp "i" 4000
	busctl call org.clightd.clightd /org/clightd/clightd/Gamma org.clightd.clightd.Gamma Set "ssi(buu)" :8 $XAUTHORITY 4000 true 50 300
	notify-send -u normal "Redshift: on"
elif [[ "$isItNightOrDay" == "0" && "$currentTemp" == "4000" ]]; then
	busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma DayTemp "i" 6500
        busctl call org.clightd.clightd /org/clightd/clightd/Gamma org.clightd.clightd.Gamma Set "ssi(buu)" :8 $XAUTHORITY 6500 true 50 300
	notify-send -u normal "Redshift: off"
elif [[ "$isItNightOrDay" == "1" && "$currentTemp" == "4000" ]]; then
	busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma NightTemp "i" 6500
        busctl call org.clightd.clightd /org/clightd/clightd/Gamma org.clightd.clightd.Gamma Set "ssi(buu)" :8 $XAUTHORITY 6500 true 50 300
       	notify-send -u normal "Redshift off"
elif [[ "$isItNightOrDay" == "1" && "$currentTemp" == "6500" ]]; then
	busctl --user set-property org.clight.clight /org/clight/clight/Conf/Gamma org.clight.clight.Conf.Gamma NightTemp "i" 4000
        busctl call org.clightd.clightd /org/clightd/clightd/Gamma org.clightd.clightd.Gamma Set "ssi(buu)" :8 $XAUTHORITY 4000 true 50 300
       	notify-send -u normal "Redshift: on"
else
	notify-send -u normal "Something borked"
fi
