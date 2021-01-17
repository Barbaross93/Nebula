#!/usr/bin/bash
#set -euo pipefail

raaw=$(~/.config/qtile/kb.py)
KeysMod=$(echo "$raaw" | awk 'BEGIN{FPAT = "([^,]+)|(\"[^\"]+\")"}{print $3, $2}' | sed "s/, /,/g" | column -t) 
Desc=$(echo "$raaw" | sed 's/, /. /g' | cut -d"," -f 5-)

#echo "$raaw"
#echo "$KeysMod"
#echo "$Desc"

paste <(echo -e "$KeysMod") <(echo -e "$Desc") | column -t -s $'\t' | rofi -no-config -theme ~/.config/rofi/configTall.rasi -dmenu -i -p "?"

