#!/usr/bin/env bash

if eww windows | grep "*border2"; then
    eww close border1 && eww close border2 && eww close border
    qtile cmd-obj -o cmd -f hide_show_bar --args top
else
    qtile cmd-obj -o cmd -f hide_show_bar --args top
    eww open border1 && eww open border2 && eww open border
fi
