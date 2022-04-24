#!/usr/bin/env bash
set -euo pipefail

muted=$(pulsemixer --get-mute)
if [[ "$muted" == "0" ]]; then
    echo "" > /tmp/vol-icon
else
    echo "" > /tmp/vol-icon
fi
