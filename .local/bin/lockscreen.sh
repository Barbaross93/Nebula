#!/usr/bin/env bash
set -euo pipefail

#lock() {
#    i3lock -n -c 242831ff -i ~/Pictures/lock_background3.png -t -e \
#        --indicator --force-clock --pass-media-keys --pass-power-keys --pass-volume-keys \
#        --insidevercolor=2e3440A8 --insidewrongcolor=2e3440A8 --insidecolor=2e344000 --ringwrongcolor=bf616a \
#        --ringcolor=81a1c1 --ringvercolor=88c0d0 --line-uses-inside --keyhlcolor=b48ead --bshlcolor=bf616a \
#        --separatorcolor=81a1c1 --verifcolor=88c0d0 --wrongcolor=bf616a --indpos="w/6:h/2-200" --timecolor=e5e9f0 \
#        --timepos="w/6:h/2+50" --timestr="%I:%M %p" --datecolor=e5e9f0 --time-font="FiraCode Nerd Font" \
#        --date-font="FiraCode Nerd Font" --verif-font="FiraCode Nerd Font" --wrong-font="FiraCode Nerd Font" \
#        --greeter-font="FiraCode Nerd Font" --greetertext="$USER" --greetercolor=e5e9f0 --greeterpos="w/6:h/2-10" \
#        --radius 120 --ring-width 3 --greetersize=36
#}

cachepath=$HOME/.cache/lockscreen
cropuser=$cachepath/$USER-pic-crop.png

width=3840       #$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*' | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/' |cut -d "x" -f 1 |head -n1)
height=2160    #$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*' | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/' |cut -d "x" -f 2 |head -n1)
half_width=$((width/2))
half_height=$((height/2))

cropuser() {
  userpic=~/Pictures/barbarossaCircle.png

	convert $userpic -resize 170x170 -gravity Center \( \
		-size 170x170 xc:Black \
		-fill White \
		-draw "circle 85 85 85 1" \
		-alpha Copy\
		\) -compose CopyOpacity -composite -trim $cropuser
}

blurbg() {
    maim -u "$cachepath/screenshot.png"
	convert "$cachepath/screenshot.png" \
		-filter Gaussian \
		-blur 0x27 \
		"$cachepath/screenshot-blur.png"
}

genbg() {
	if [[ ! -d $HOME/.cache/lockscreen ]]; then
		mkdir $HOME/.cache/lockscreen
    cropuser
	fi
	blurbg
	composite -geometry "+$((half_width-85))+$((half_height-137))" $cropuser $cachepath/screenshot-blur.png $cachepath/screenshot-pic-blur.png
}

lock() {
	i3lock -n -c 00000000 -e --date-str="@$(uname -n)" -i ~/Pictures/nordspace_lock.png -F --date-pos="w/2:h/2+90" \
        --indicator --force-clock --pass-media-keys --pass-power-keys --pass-volume-keys --date-size=16 \
        --insidever-color=2e3440A8 --insidewrong-color=2e3440A8 --inside-color=2e344000 --ringwrong-color=bf616a \
        --ring-color=81a1c1 --ringver-color=88c0d0 --line-uses-inside --keyhl-color=b48ead --bshl-color=bf616a \
        --separator-color=81a1c1 --verif-color=88c0d0 --wrong-color=bf616a --ind-pos="w/2:h/2-42" --time-color=e5e9f0 \
        --time-pos="w/2:h/2+35" --time-str="%I:%M %p" --date-color=e5e9f0 --time-font="FiraCode Nerd Font" \
        --date-font="FiraCode Nerd Font" --verif-font="FiraCode Nerd Font" --wrong-font="FiraCode Nerd Font" \
        --greeter-font="FiraCode Nerd Font:style=Bold" --greeter-text="$USER" --greeter-color=8fbcbb --greeter-pos="w/2:h/2+70" \
        --radius 50 --ring-width 3 --greeter-size=18 --time-size=14 --verif-size=10 --wrong-size=10  --modif-size=9 --modif-pos="w/2:h/2-15" #--no-verify
}

status=$(playerctl status || true)

#genbg
if [ "$status" == "Playing" ]; then
	playerctl pause
fi
dunstctl set-paused true
#if pgrep -x "picom" >/dev/null; then
#	true
#else
#	setsid -f picom --experimental-backends &
#fi
# If rofi is opened, it grabs the keyboard and borks i3lock. Not sure how to
# take a general approach to see if the keyboard is actively grabbed
if pgrep -x rofi; then
	killall rofi
fi
lock || lockscreen.sh
if [ "$status" == "Playing" ]; then
	playerctl play
fi
dunstctl set-paused false
