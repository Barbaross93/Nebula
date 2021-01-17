#!/usr/bin/env bash
set -euo pipefail

color=$(gpick -so 2>/dev/null)

if [ -n "$color" ]; then
    dunstify -i /usr/share/icons/Nord-Icon/48x48/apps/color-picker.svg -a ColorPicker -u normal "$color"
fi
