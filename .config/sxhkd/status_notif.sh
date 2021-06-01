#!/bin/sh

#TODO:
# make rampable icons for audio, brightness, battery, wifi (might be a pita to implement this)
#add a progress bar for brightness and volumne full view; see bright and vol scripts
#fix bspwm node flags; they dont appear for some reason

bspwm() {
	desktop_info=$(bspc query -T -d | jq -r '.name, .layout')
	desktop_name=$(echo "$desktop_info" | head -1)
	desktop_layout=$(echo "$desktop_info" | tail -1)
	node_info=$(bspc query -T -n | jq -r '.sticky, .private, .locked, .marked, .client.state')
	node_flags=$(echo "$node_info" | head -4)
	node_state=$(echo "$node_info" | tail -1)

	a=0
	stick=""
	private=""
	locked=""
	marked=""
	for x in $node_flags; do
		a=$(( a + 1 ))
		if $x && [ $a -eq 1 ]; then
			stick=" "
		elif $x && [ $a -eq 2 ]; then
			private=" "
		elif $x && [ $a -eq 3 ]; then
			locked=" "
		elif $x && [ $a -eq 4 ]; then
			marked=" "
		fi
	done
	flags="$stick$private$locked$marked"
	flags=${flags:1}

	if [[ "$node_state" == "tiled" ]]; then
		state=""
	else
		state="$node_state"
	fi

	case "$1" in
		-s|--simple)
			echo " | $desktop_name"
			;;
		-f|--full)
			if [ "$state" = "" ] || [ "$flags" = "" ]; then
				echo " | $desktop_name, $desktop_layout"
			else
				echo "□ | $desktop_name, $desktop_layout\n$state $flags"
			fi
			;;
	esac
}

calendar() {
	time=$(date +"%I:%M %p")
	date=$(date +"%A, %B %d")

	case "$1" in
		-s|--simple)
			echo " | $time"
			;;
		-f|--full)
			echo " | $time\n | $date"
			;;
	esac
}

audio() {
	case "$1" in
		-s|--simple)
			mute_state=$(pulsemixer --get-mute)

			if [[ "$mute_state" == "0" ]]; then
				vol=$(pulsemixer --get-volume | awk '{print $1}')
				vol="$vol%"
			elif [[ "$mute_state" == "1" ]]; then
				vol="Muted"
			fi
	
			if [ "$vol" = "Muted" ]; then
				echo " | $vol"
			else
				echo " | $vol"
			fi
			;;
		-f|--full)
			FULL=""
			EMPTY=""
			value="${3:-5}"
			
			mute_state=$(pulsemixer --get-mute)

			if [[ "$mute_state" == "0" ]]; then
				vol=$(pulsemixer --get-volume | awk '{print $1}')
				vol="$vol"
			elif [[ "$mute_state" == "1" ]]; then
				vol="Muted"
			fi
	
			if [ "$vol" = "Muted" ]; then
				echo " | $vol"
			else
				barFull=$(seq -s "$FULL" $((vol / 10)) | sed 's/[0-9]//g')
				barEmpty=$(seq -s "$EMPTY" $((11 - vol / 10)) | sed 's/[0-9]//g')

				echo -e " | $barFull$barEmpty $vol%"
			fi
			;;
	esac
}

brightness() {
	case "$1" in
		-s|--simple)
			brightness=$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}')
			brightness=$(echo "($brightness+0.5)/1" | bc)
			echo " | $brightness%"
			;;
		-f|--full)
			FULL=""    #"•"
			EMPTY=""     #"○"
			value="${2:-5}"
			brightness="$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}')"
			barFull=$(seq -s "$FULL" $((brightness / 10)) | sed 's/[0-9]//g')
			barEmpty=$(seq -s "$EMPTY" $((11 - brightness / 10)) | sed 's/[0-9]//g')
			echo -e " | $barFull$barEmpty $brightness%"
			;;
	esac
}

battery() {
	case "$1" in
		-s|--simple)
			if [ "$(acpi | wc -l)" = "1" ]; then
				if [ "$(acpi | awk '{print $3}')" = "Charging," ]; then
					echo " | $(acpi | awk '{print $4}' | cut -d',' -f1)"
				elif [ "$(acpi | awk '{print $3}')" = "Full," ]; then
					echo " | Full"
				else
					echo " | $(acpi | awk '{print $4}' | cut -d',' -f1)"
				fi
			else
				if [ "$(acpi | awk 'NR==2 {print $3}')" = "Charging," ]; then
					echo " | $(acpi | awk 'NR==2 {print $4}' | cut -d',' -f1)"
				elif [ "$(acpi | awk 'NR==2 {print $3}')" = "Full," ]; then
					echo " | Full"
				else
					echo " | $(acpi | awk 'NR==2 {print $4}' | cut -d',' -f1)"
				fi
			fi
			;;
		-f|--full)
			if [ "$(acpi | wc -l)" = "1" ]; then
				state=$(acpi | awk '{print $3}')
				if [ "$state" = "Charging," ]; then
					percent=$(acpi | awk '{print $4}' | cut -d',' -f1)
					time=$(acpi | awk NR==1 | awk '{print $5, $6, $7}')
					echo " | $percent, $time"
				elif [ "$state" = "Full," ]; then
					echo " | Full"
				else
					percent=$(acpi | awk '{print $4}' | cut -d',' -f1)
					time=$(acpi | awk NR==1 | awk '{print $5, $6}')
					" | $percent, $time"
				fi
			else
				state=$(acpi | awk 'NR==2 {print $3}')
				if [ "$state" = "Charging," ]; then
					percent=$(acpi | awk 'NR==2 {print $4}' | cut -d',' -f1)
					time=$(acpi | awk 'NR==2 {print $5, $6, $7}')
					echo " | $percent, $time"
				elif [ "$state" = "Full," ]; then
					echo " | Full"
				else
					percent=$(acpi | awk 'NR==2 {print $4}' | cut -d',' -f1)
					time=$(acpi | awk 'NR==2 {print $5, $6}')
					echo " | $percent, $time"
				fi
			fi
			;;
	esac
}

internet() {
	case "$1" in
		-f|--full)
			simple=false
			;;
		-s|--simple|*)
			simple=true
			;;			
	esac

	connection_type=$(ip link | grep "state UP" | awk '{print $2}' | cut -d':' -f 1)

	if [ "$connection_type" = "enp5s0" ]; then
		echo " | $connection_type"
	elif [ "$connection_type" = "wlan0" ]; then
		dbm=$(cat /proc/net/wireless | grep wlan0 | awk '{print $4}')
		dbmfinal=${dbm%.*}
		if [ $dbmfinal -le -100 ]; then
			quality=0
		elif [ $dbmfinal -ge -50 ]; then
			quality=100
		else
			quality=$((2 * ($dbmfinal + 100)))
		fi
		signal=$quality%
		ssid=$(connmanctl services | grep "*AO" | awk '{print $2}')
		if $simple; then
			echo " | $signal"
		else
			echo " | $signal $ssid"
		fi
	else
		echo "internet: Disconnected"
	fi
}

case "$1" in
	--bspwm)
		wm=$(bspwm --full)
		notify-send --app-name="status" -u normal -t 3000 "$wm"
		;;
	--calendar)
		cal=$(calendar --full)
		notify-send --app-name="status" -u normal -t 3000 "$cal"
		;;
	--audio)
		sound=$(audio --full)
		notify-send --app-name="status" -u normal -t 3000 "$sound"
		;;
	--brightness)
		light=$(brightness --full)
		notify-send --app-name="status" -u normal -t 3000 "$light"
		;;
	--battery)
		power=$(battery --full)
		notify-send --app-name="status" -u normal -t 3000 "$power"
		;;
	--internet)
		interweb=$(internet --full)
		notify-send --app-name="status" -u normal -t 3000 "$interweb"
		;;
	--full)
		wm=$(bspwm --full)
		cal=$(calendar --full)
		sound=$(audio --full)
		light=$(brightness --full)
		#power=$(battery --full)
		interweb=$(internet --full)
		full=$(echo -e "$wm\n$cal\n$sound\n$light\n$interweb")
		notify-send -u normal -t 5000 "$full"
		;;
	--simple|*)
		wm=$(bspwm --simple)
		cal=$(calendar --simple)
		sound=$(audio --simple)
		light=$(brightness --simple)
		#power=$(battery --simple)
		interweb=$(internet --simple)
		simple=$(echo -e "$wm\n$cal\n$sound\n$light\n$interweb")
		notify-send -u normal -t 5000 "$simple"
		;;
esac
