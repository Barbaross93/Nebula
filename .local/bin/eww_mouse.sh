#!/usr/bin/env bash
set -euo pipefail

eww open main_bottom

sleep 0.2
WIN_ID=$(xdotool search --name 'Eww - main_bottom')

xev -id "$WIN_ID" -event mouse | while read line; do
     if [[ "$line" =~ ^LeaveNotify.* ]]; then
         sleep 0.2
         eww close main_bottom
         pkill xev
     fi
done
