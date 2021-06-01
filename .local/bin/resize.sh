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

#size=${2:-'60'}
#direction=$1

#bspc query -N -n focused.floating
#floating=$?

#case "$direction" in
#  west)  [ $floating = 0 ] && bspc node -z right -"$size" 0 || bspc node @west  -r -"$size" || bspc node @east  -r -"$size" ;;
#  east)  [ $floating = 0 ] && bspc node -z right +"$size" 0 || bspc node @west  -r +"$size" || bspc node @east  -r +"$size" ;;
#  north) [ $floating = 0 ] && bspc node -z bottom 0 -"$size" || bspc node @south -r -"$size" || bspc node @north -r -"$size" ;;
#  south) [ $floating = 0 ] && bspc node -z bottom 0 +"$size" || bspc node @south -r +"$size" || bspc node @north -r +"$size" ;;
#esac

#delta=${2:-"30"}
#Delta values are 2% of resolution in each direction
case $1 in
  east)  dim=w; sign=+; delta=77 ;;
  west)   dim=w; sign=-; delta=77 ;;
  north)     dim=h; sign=-; delta=43 ;;
  south)   dim=h; sign=+; delta=43 ;;
  *) echo "Usage: resize {up,down,left,right} [delta]" && exit 1 ;;
esac

x=0; y=0;
case $dim in
  w) x=$sign$delta;  dir=right;  falldir=left   ;;
  h) y=$sign$delta;  dir=top;    falldir=bottom ;;
esac

bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y";
