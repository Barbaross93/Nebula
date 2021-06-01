#!/bin/sh
#  resize window

percent=2

case $1 in
	# dimension  direction  fallback-dir  sign
	west)  set -- width right left -;;
	east)  set -- width right left +;;
	north) set -- height bottom top -;;
	south) set -- height bottom top +
esac

# 5% of monitor res
#set -- "$@" "$4$(($(mattr ${1%%[ie]*} "$(pfm)") * 5 / 100 ))"
#set -- "$@" "${4}40"

mon=$(bspc query -M -m --names)

if [[ "$1" == "width" ]]; then
	xdim=$(xrandr | grep "${mon} connected" | grep -E -o "[0-9]+" | sed -n 2p)
	set -- "$@" "$4$(($xdim * $percent / 100 ))"
elif [[ "$1" == "height" ]]; then
	ydim=$(xrandr | grep "${mon} connected" | grep -E -o "[0-9]+" | sed -n 3p)
	set -- "$@" "$4$(($ydim * $percent / 100 ))"
fi

[ "$1" = width  ] && { x=$5; y=0; }
[ "$1" = height ] && { y=$5; x=0; }

# try to resize in one direction
# fall back to the other if it fails
bspc node -z "$2" "$x" "$y" || bspc node -z "$3" "$x" "$y"
