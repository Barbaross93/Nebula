#!/bin/sh

greenclip print | sed '/^$/d' | rofi -theme ~/.config/rofi/configTall.rasi -dmenu -i -l 10 -p  -columns 1 | xargs -r -d'\n' -I '{}' greenclip print '{}'

