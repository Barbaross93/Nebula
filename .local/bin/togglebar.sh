#!/bin/sh

gap="$(bspc config top_padding)"

if [ $gap -eq 68 ]
then
	polybar-msg cmd hide bar
	#eww close border
	bspc config top_padding 9
else
	bspc config top_padding 68
	polybar-msg cmd show bar
	#eww open border
fi
