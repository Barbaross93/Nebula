#!/usr/bin/env bash

msg() {
	rofi -theme "~/.config/rofi/powermenu/message.rasi" -e "Available Options  -  yes / y / no / n"
}

main() {
	#yad --title Alert --no-focus --button=yes:0 --button=no:1 --borders=15 --text "Load default layout?"
	ans=$(rofi -dmenu -i -no-fixed-num-lines -p "Load default layout? : " -theme ~/.config/rofi/powermenu/confirm.rasi -kb-custom-1 Return -kb-accept-entry Control+m)
	code=$?
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" || -z $ans && $code -eq 10 ]]; then	
    bspc wm -l $HOME/.config/bspwm/layouts/default/default_canvas.json
    sh $HOME/.config/bspwm/layouts/default/default_rules.sh
    $HOME/.config/bspwm/layouts/default/default_startup.sh &
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" || -z $ans ]]; then
		exit 0
	else
		msg
		main
	fi
}

main
