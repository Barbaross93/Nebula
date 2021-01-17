#!/usr/bin/env bash
set -euo pipefail

if [ -p /tmp/bright ]; then
    true
else
    mkfifo /tmp/bright && echo "$(busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get \"s\" \"\" | awk '{print $3*100}')" > /tmp/bright
fi

script_name="eww_bright.sh"
for pid in $(pgrep -f $script_name); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi 
done

start=$SECONDS

eww_wid="$(xdotool search --name 'Eww - bright' || true)"

if [ ! -n "$eww_wid" ]; then
    eww open bright
fi

case $1 in
up)
	busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight RaiseAll "d(bdu)s" 0.05 0 0 0 ""
	label=""
	;;
down)
	busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight LowerAll "d(bdu)s" 0.05 0 0 0 ""
	label=""
	;;
esac

busctl call org.clightd.clightd /org/clightd/clightd/Backlight org.clightd.clightd.Backlight Get "s" "" | awk '{print $3*100}' > /tmp/bright

while [ -n "$eww_wid" ]; do
    duration=$(( SECONDS - start ))
    if [[ $duration -gt 2 ]]; then
        eww close bright
        eww_wid="$(xdotool search --name 'Eww - bright' || true)"       
    fi
    sleep 0.2
done
