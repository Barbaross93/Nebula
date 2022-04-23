#!/usr/bin/env bash

status=$(eww windows | grep "*" | wc -l)

if [ $status -eq 3 ]; then
	eww close border
	eww close border1
	eww close border2
	qtile cmd-obj -o cmd -f hide_show_bar -a top
	qtile cmd-obj -o cmd -f eval -a "self.current_screen.top.size += 18" && qtile cmd-obj -o cmd -f eval -a "self.current_group.layout_all()"
	#feh-blur -s
	#feh --no-fehbg --bg-fill ~/Pictures/colors/242831.png
	#cky &
else
	#pkill -f conky
	#feh-blur --darken 0 -b 6 &
	qtile cmd-obj -o cmd -f eval -a "self.current_screen.top.size -= 18" && qtile cmd-obj -o cmd -f eval -a "self.current_group.layout_all()"
	qtile cmd-obj -o cmd -f hide_show_bar -a top
	eww open border
	eww open border1
	eww open border2
fi
