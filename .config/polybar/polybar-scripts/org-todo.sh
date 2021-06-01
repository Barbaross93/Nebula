#!/usr/bin/env bash
#set -euo pipefail

task=$(grep "START" ~/Documents/org/TODO.org | head -n1 | cut -d' ' -f3-)

if [ -n "$task" ]; then
    echo " $task"
else
    echo " No current task"
fi
