#!/bin/sh

status=$(dunstctl is-paused)
dunstify -u normal -t 3000 -r 669 "Dunst paused: $status"
