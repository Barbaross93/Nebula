#!/usr/bin/env bash

if [[ "$1" = "+" ]]; then
	bspc config -d focused left_padding $((`bspc config -d focused left_padding ` + 16 ))
	bspc config -d focused right_padding $((`bspc config -d focused right_padding ` + 16 ))
	bspc config -d focused top_padding $((`bspc config -d focused top_padding ` + 8 ))
	bspc config -d focused bottom_padding $((`bspc config -d focused bottom_padding ` + 8 ))
else
	bspc config -d focused left_padding $((`bspc config -d focused left_padding ` - 16 ))
	bspc config -d focused right_padding $((`bspc config -d focused right_padding ` - 16 ))
	bspc config -d focused top_padding $((`bspc config -d focused top_padding ` - 8 ))
	bspc config -d focused bottom_padding $((`bspc config -d focused bottom_padding ` - 8 ))
fi
