#!/usr/bin/env bash
set -euo pipefail

date=$(date +"%A, %B %d")

notify-send -a Calendar -u normal -i /usr/share/icons/Nord-Icon/48x48/apps/calendar.svg "$date"
