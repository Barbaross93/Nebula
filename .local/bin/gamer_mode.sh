#!/bin/sh

# Epic gamer mode activate!
pkill xbanish
dunstctl set-paused true

# Gamer time 😎
"$@"

# Le epic gamer mode deactivate!
( xbanish &  )
dunstctl set-paused false
