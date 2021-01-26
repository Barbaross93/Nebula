#!/bin/sh

# Will need to update usr/lib/node_modules/rofi-search/rofi-search when rofi-search updates to change default prompt

#export ROFI_SEARCH='googler'
#export GOOGLE_ARGS='["--count", 13]'
export GOOGLE_API_KEY='{YOUR_API_KEY HERE}'
export GOOGLE_SEARCH_ID='{YOUR SEARCH ID HERE}'
export ROFI_SEARCH='cse'

export TITLE_COLOR='#5e81ac'
export ROFI_SEARCH_CMD='linkhandler $URL'

rofi -modi blocks -blocks-wrap /usr/bin/rofi-search -show blocks -lines 13 -eh 4 -kb-custom-1 'Control+y' -theme ~/.config/rofi/configTall.rasi  
