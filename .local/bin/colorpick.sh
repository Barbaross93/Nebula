#!/usr/bin/env bash
set -euo pipefail

#color=$(gpick -so 2>/dev/null)
color=$(xcolor)

if [ -n "$color" ]; then
    random_file=$(mktemp --suffix ".png")
    convert -size 100x100 xc:"$color" "$random_file"
    dunstify -i "$random_file" -a ColorPicker -u normal "$color"
fi
