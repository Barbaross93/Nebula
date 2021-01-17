#!/usr/bin/env bash
set -euo pipefail

muted=$(pulsemixer --get-mute)
if [[ "$muted" == "0" ]]; then
	echo -n ""
else 
	echo -n ""
fi
