#!/usr/bin/env bash

trap "feh-blur --darken 0 -b 6 -d; pkill glava" SIGTERM SIGINT

feh-blur -s &>/dev/null
glava -e rc.glsl --desktop &>/dev/null &
glava -e rc2.glsl --desktop &>/dev/null &

wait
