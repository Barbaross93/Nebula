#!/bin/sh

show() {
	for x in $(xdotool search --name Polybar); do
		xdotool windowmove --relative $x 0 1
		xdotool windowmove --relative $x 0 1
	done
	for i in $(seq -4 36); do
		bspc config top_padding $i
		for y in $(xdotool search --name Polybar); do
			xdotool windowmove --relative $y 0 1
		done
	done
}

hide() {	
	for i in $(seq 36 -1 -4); do
		for x in $(xdotool search --name Polybar); do
			xdotool windowmove --relative $x 0 -1
		done
		#xdotool search --name Polybar windowmove --relative -- 0 -1
		bspc config top_padding $i
	done
	for y in $(xdotool search --name Polybar); do
		xdotool windowmove --relative $y 0 -1
		xdotool windowmove --relative $y 0 -1
	done
}

toggle() {
	pad=$(bspc config top_padding)
	if [[ "$pad" == "36" ]]; then
		hide
	else
		show
	fi
}

case "$1" in
	-s|--show)
		show
		;;
	-h|--hide)
		hide
		;;
	-t|--toggle)
		toggle
		;;
	*)
		toggle
		;;
esac
