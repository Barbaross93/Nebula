#!/bin/sh

if [ "$(pgrep -x redshift)" ]; then
    temp=$(redshift -l 39.2904:-76.6122 -p 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")

    if [ -z "$temp" ]; then
        echo "%{F#3b4252}"
    elif [ "$temp" -ge 5000 ]; then
        echo "%{F#8fbcbb}"
    elif [ "$temp" -ge 4000 ]; then
        echo "%{F#d08770}"
    else
        echo "%{F#d08770}"
    fi
else
    echo "%{F#3b4252}"
fi
