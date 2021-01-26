#!/usr/bin/env bash

if [[ $(xset q | grep Enabled | awk '{print $3}') == "Enabled" ]];
then
    xset s off
    xset -dpms
    pkill idle.sh
    notify-send -a Caffeine -i /usr/share/icons/Nord-Icon/48x48/apps/caffeine.svg -u normal -t 3000 "Caffeine Enabled"    
    #dunstify -u normal -t 3000 -r 5534 " Caffeine Enabled"
else
    xset s on
    xset +dpms
    #xset s 420 179
    idle.sh 7 screensaver &
    notify-send -a Caffeine -i /usr/share/icons/Nord-Icon/48x48/apps/caffeine.svg -u normal -t 3000 "Caffeine Disabled"
    #dunstify -u normal -t 3000 -r 5534 " Caffeine Disabled"
fi
