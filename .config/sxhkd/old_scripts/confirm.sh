#!/bin/bash
message="${1:-"Confirm?"}"
response=$(echo -e "No\nYes" | rofi -dmenu -i -p "$message ")

if [ "$response" = "Yes" ]; then
  exit 0;
else
  exit 1;
fi