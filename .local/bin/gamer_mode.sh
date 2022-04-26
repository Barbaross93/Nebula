#!/bin/sh

# Epic gamer mode activate!
systemctl --user stop xbanish
dunstctl set-paused true
systemctl --user stop picom

# Gamer time 😎
"$@"

# Le epic gamer mode deactivate!
systemctl --user start xbanish
dunstctl set-paused false
systemctl --user start picom
