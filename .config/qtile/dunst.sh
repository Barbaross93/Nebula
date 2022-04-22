#!/usr/bin/env bash

status() {
  state=$(dunstctl is-paused)
  if [[ "$state" == "false" ]]; then
    echo ""
  else
    echo "<span foreground='#3b4252'></span>"
  fi
}


case "$1" in
  --toggle|-t)
    dunstctl set-paused toggle
    ;;
  --notif-center|-nc)
    rofi_notif_center.sh
    ;;
  *)
    status
    ;;
esac
