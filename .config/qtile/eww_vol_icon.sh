#!/usr/bin/env bash
set -euo pipefail

case $1 in
    mute)
        muted=$(pulsemixer --get-mute)
            if [[ "$muted" == "0" ]]; then
                echo "" > /tmp/vol-icon
            else 
                echo "" > /tmp/vol-icon
            fi
    ;;
esac
