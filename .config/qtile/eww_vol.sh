#!/usr/bin/env bash
set -euo pipefail

mute () {
     muted=$(pulsemixer --get-mute)
     if [[ "$muted" == "0" ]]; then
        echo "" > /tmp/vol-icon
    else 
        echo "" > /tmp/vol-icon
    fi
}

if [ -p /tmp/vol ] && [ -p /tmp/vol-icon ]; then
    true
else
    mkfifo /tmp/vol && echo "$(pulsemixer --get-volume | awk '{print $1}')" > /tmp/vol 
    mkfifo /tmp/vol-icon && mute
fi

script_name="eww_vol.sh"
for pid in $(pgrep -f $script_name); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi 
done

start=$SECONDS
value=5

eww_wid="$(xdotool search --name 'Eww - vol' || true)"

if [ ! -n "$eww_wid" ]; then
    eww open vol
    eww_wid="$(xdotool search --name 'Eww - vol' || true)"
fi

case $1 in
    up)
        currentVolume=$(pulsemixer --get-volume | awk '{print $1}')
               if [[ "$currentVolume" -ge "100" ]]; then
                   pulsemixer --max-volume 100
               else
                   pulsemixer --change-volume +"$value"
               fi
    ;;
    down)
        pulsemixer --change-volume -"$value"
    ;;
    mute)
        muted=$(pulsemixer --get-mute)
            if [[ "$muted" == "0" ]]; then
                pulsemixer --toggle-mute
                echo "" > /tmp/vol-icon
            else 
                pulsemixer --toggle-mute
                echo "" > /tmp/vol-icon
            fi
    ;;
esac

echo $(pulsemixer --get-volume | awk '{print $1}') > /tmp/vol 

while [ -n "$eww_wid" ]; do
    duration=$(( SECONDS - start ))
    if [[ $duration -gt 1 ]]; then
        eww close vol
        eww_wid="$(xdotool search --name 'Eww - vol' || true)"       
    fi
    sleep 0.2
done

