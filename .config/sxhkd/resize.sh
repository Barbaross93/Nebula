#!/bin/bash
# Extracted and adapted from source:
# https://github.com/Chrysostomus/bspwm-scripts/blob/master/bin/bspwm_resize.sh

# Resizes (expands or contracts) the selected node in the given
# direction.  This is assigned to a key binding in $HOME/.config/sxhkd/sxhkdrc

# NOTE by Protesilaos 2020-05-01: The support for floating windows was
# contributed by Pierre-François Bonnefoi who also recommends the
# following sxhkdrc config:
#
# super + ctrl + {Left,Down,Up,Right}
#     bspwm_resize {west,south,north,east} 50

size=${2:-'10'}
direction=$1

bspc query -N -n focused.floating
floating=$?

case "$direction" in
  west)  [ $floating = 0 ] && bspc node -z right -"$size" 0 || bspc node @west  -r -"$size" || bspc node @east  -r -"$size" ;;
  east)  [ $floating = 0 ] && bspc node -z right +"$size" 0 || bspc node @west  -r +"$size" || bspc node @east  -r +"$size" ;;
  north) [ $floating = 0 ] && bspc node -z bottom 0 -"$size" || bspc node @south -r -"$size" || bspc node @north -r -"$size" ;;
  south) [ $floating = 0 ] && bspc node -z bottom 0 +"$size" || bspc node @south -r +"$size" || bspc node @north -r +"$size" ;;
esac

