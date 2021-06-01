#!/usr/bin/bash

eww daemon
while true; do
    if eww ping; then 
        eww open border &
        #eww open border1 &
        #eww open border2 &
        break
    fi
done &
