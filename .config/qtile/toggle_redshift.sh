#!/usr/bin/env bash
set -euo pipefail

if pidof redshift; then
    pkill redshift
    notify-send -u normal -a Redshift -t 3000 -i /usr/share/icons/Nord-Icon/48x48/apps/redshift.svg "Redshift disabled"
else
    redshift -l 39.2904:-76.6122 &
    notify-send -u normal -a Redshift -t 3000 -i /usr/share/icons/Nord-Icon/48x48/apps/redshift.svg "Redshift enabled"
fi
