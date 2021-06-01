#!/bin/sh

#TODO:
# make rampable icons for audio, brightness, battery, wifi (might be a pita to implement this)
#add a progress bar for brightness and volumne full view; see bright and vol scripts
#fix bspwm node flags; they dont appear for some reason

bspwm() {
	desktop_info=$(bspc query -T -d | jq -r '.name, .layout')
	desktop_name=$(echo "$desktop_info" | head -1)
	desktop_layout=$(echo "$desktop_info" | tail -1)
	
	focused_node=$(bspc query -T -n)
	# Should return tiled, pseudo_tiled, floating, or fullscreen
	state=$(echo -n "$focused_node" | jq -r '.client.state')
	locked=$(echo -n "$focused_node" | jq -r '.locked')
	sticky=$(echo -n "$focused_node" | jq -r '.sticky')
	private=$(echo -n "$focused_node" | jq -r '.private')
	marked=$(echo -n "$focused_node" | jq -r '.marked')

	#unset state_list
	if [[ "$state" == "pseudo_tiled" ]]; then
		state_list=${state_list}${state_list:+,}
	elif [[ "$state" == "floating" ]]; then
		state_list=${state_list}${state_list:+,}
	elif [[ "$state" == "fullscreen" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$locked" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$sticky" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$private" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$marked" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi

	sani_list=$(echo -n "$state_list" | tr ',' ' ')
	
	if [ -z "$sani_list" ]; then
		sani_list=""
	else
		sani_list=" $sani_list"
	fi

	if [[ "$desktop_layout" == "tiled" ]]; then
		layout=
	else
		layout=
	fi

	case "$1" in
		-s|--simple)
			echo "● $desktop_name"
			;;
		-f|--full)
			if [ -n "$sani_list" ]; then
				echo "● $desktop_name: $layout,$sani_list"
			else
				echo "● $desktop_name: $layout"
			fi
			;;
	esac
}

hlwm() {
	current_tag=$(herbstclient list_monitors | grep "FOCUS" | awk '{print $5}' | sed -e 's/^"//' -e 's/"$//')

	layout=$(herbstclient attr tags.focus.tiling.focused_frame.algorithm)
	if [[ "$layout" == "horizontal" ]]; then
		icon=
	elif [[ "$layout" == "vertical" ]]; then
		icon=
	elif [[ "$layout" == "max" ]]; then
		icon=
	elif [[ "$layout" == "grid" ]]; then
		icon=
	fi
	
	case "$1" in
		-s|--simple)
			echo " | $current_tag"
			;;
		-f|--full)
			echo " | $current_tag: $icon"
			;;
	esac
}

qqtile() {
	desktop_raw=$(wmctrl -d | grep "*" | awk '{print $1}')
	desktop=$(( desktop_raw + 1 ))
	layout=$(qtile cmd-obj -o group -f info | grep layout | head -n1 | awk '{print $2}' | tr -d "'" | tr -d ",")
	
	case "$1" in
		-s|--simple)
			echo " ● $desktop"
			;;
		-f|--full)
			echo " ● $desktop: $layout"
			;;
	esac
}

calendar() {
	time=$(date +"%I:%M %p")
	date=$(date +"%A, %B %d")

	case "$1" in
		-s|--simple)
			echo " ● $time"
			;;
		-f|--full)
			echo " ● $time\n ● $date"
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
				echo " ● $vol"
			else
				echo " ● $vol"
			fi
			;;
		-f|--full)
			FULL=""
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
				echo " ● $vol"
			else
				barFull=$(seq -s "$FULL" $((vol / 10)) | sed 's/[0-9]//g')
				barEmpty=$(seq -s "$EMPTY" $((11 - vol / 10)) | sed 's/[0-9]//g')

				echo -e " ● $barFull$barEmpty $vol%"
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
			value="${3:-5}"
			brightness="$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}')"
			brightness=$(echo "($brightness+0.5)/1" | bc)
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
					echo " | $percent, $time"
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

netman() {
	case "$1" in
		-f|--full)
			simple=false
			;;
		-s|--simple|*)
			simple=true
			;;			
	esac

	connection_type=$(nmcli d | grep connected | head -1 | awk '{print $1}')

	if [ "$connection_type" = "enp7s0f1" ]; then
		echo " | $(nmcli d | grep connected | awk '{print $4}')"
	elif [ "$connection_type" = "wlp8s0" ]; then
		signal=$(nmcli -g IN-USE,SIGNAL d wifi list | grep "*" | cut -d':' -f2)
		ssid=$(nmcli -g IN-USE,SSID d wifi list | grep "*" | cut -d':' -f2)
		if $simple; then
			echo " | $signal%"
		else
			echo " | $signal%, $ssid"
		fi
	else
		echo "internet: Disconnected"
	fi
}

connman() {
	essid=$(connmanctl services | grep "*AO" | awk '{print $2}')
	unique_id=$(connmanctl services | grep "*AO" | awk '{print $3}')
	strength=$(connmanctl services $unique_id | grep "Strength" | awk '{print $3}')

	case "$1" in
		-s|--simple)
			echo " ● $strength%"
			;;
		-f|--full)
			echo " ● $strength, $essid"
			;;
	esac
}

taskwarrior() {	
	case "$1" in
		-f|--full)
			simple=false
			;;
		-s|--simple|*)
			simple=true
			;;			
	esac

	#most_urgent_desc=`task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next`
	#most_urgent_urgency=`task rc.verbose: rc.report.next.columns:urgency rc.report.next.labels:1 limit:1 next`
	#most_urgent_due=`task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next`
	active_task=`task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=description.desc rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1'`
	active_due=`task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=due rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1'`

	if $simple; then
		if [ -n "$active_task" ]; then
			echo " ● $active_task"
		fi
	elif [[ "$simple" == "false" ]]; then
		if [ -n "$active_due" ]; then
			echo " ● $active_task ·  $active_due"
		elif [ -n "$active_task" ]; then 
			echo " ● $active_task"
		fi
	fi
}

case "$1" in
	--bspwm)
		wm=$(bspwm --full)
		notify-send --app-name="Status" -u normal -t 3000 "$wm"
		;;
	--calendar)
		cal=$(calendar --full)
		notify-send --app-name="Status" -u normal -t 3000 "$cal"
		;;
	--audio)
		sound=$(audio --full)
		notify-send --app-name="Status" -u normal -t 3000 "$sound"
		;;
	--brightness)
		light=$(brightness --full)
		notify-send --app-name="Status" -u normal -t 3000 "$light"
		;;
	--battery)
		power=$(battery --full)
		notify-send --app-name="Status" -u normal -t 3000 "$power"
		;;
	--internet)
		interweb=$(connman --full)
		notify-send --app-name="Status" -u normal -t 3000 "$interweb"
		;;
	--task)
		task=$(taskwarrior --full)
		notify-send --app-name="Status" -u normal -t 3000 "$task"
		;;
	--full)
		wm=$(bspwm --full)
		cal=$(calendar --full)
		sound=$(audio --full)
		#light=$(brightness --full)
		#power=$(battery --full)
		interweb=$(connman --full)
		task=$(taskwarrior --full)
		full=$(echo -e "$wm\n$cal\n$sound\n$interweb\n$task")
		notify-send -a Status -u normal -t 5000 "$full"
		;;
	--simple|*)
		wm=$(qqtile --simple)
		cal=$(calendar --simple)
		sound=$(audio --simple)
		#light=$(brightness --simple)
		#power=$(battery --simple)
		interweb=$(connman --simple)
		task=$(taskwarrior --simple)
		simple=$(echo -e "$wm\n$cal\n$sound\n$interweb\n$task")
		notify-send -a Status -u normal -t 5000 "$simple"
		;;
esac
