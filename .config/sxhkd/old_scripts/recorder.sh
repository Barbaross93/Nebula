#!/bin/bash
# return early instead of if else
if pidof ffmpeg
  then
    killall ffmpeg

    notify-send ' Stopped Recording!'
  else 
    #slop=$(slop -f "%x %y %w %h")

    #read -r X Y W H #< <(echo $slop)

    time=$(date +%F%T)

    # only start recording if we give a width (e.g we press escape to get out of slop - don't record)
    #width=${#W}

    if [ 1366 -gt 0 ]; #replace 1366 with $width
     then
      notify-send ' Started Recording!'
      
      # records without audio for audio add: -f alsa -i pulse 
      ffmpeg -f x11grab -draw_mouse 0 -s "1366"x"768" -framerate 25 -thread_queue_size 512 -i $DISPLAY.0+0,0 \
       -f pulse -ac 2 -i default \
       -c:v libx264 -qp 18 -preset ultrafast \
       -pix_fmt yuv420p \
       ~/Videos/recording-$time.mp4
    fi
fi
