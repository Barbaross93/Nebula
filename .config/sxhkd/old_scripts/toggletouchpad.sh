#!/bin/sh
# Toggle touchpad status
# Using libinput and xinput

# Use xinput list and do a search for touchpads. Then get the first one and get its name.
device="ETPS/2 Elantech Touchpad"

on() {
	xinput enable "$device"
	dunstify -u normal -t 3000 -r 2298 " Touchpad enabled"
}

off() {
	xinput disable "$device"
	dunstify -u normal -t 3000 -r 2298 " Touchpad disabled"
}

# If it was activated disable it and if it wasn't disable it
[[ "$(xinput list-props "$device" | grep -P ".*Device Enabled.*\K.(?=$)" -o)" == "1" ]] &&
    off ||
    on
