#!/bin/bash


if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1f/usr/share/icons/Nord-Icon/48x48/apps/system-shutdown.svg\n"
    echo -en "Reboot\0icon\x1f/usr/share/icons/Nord-Icon/48x48/apps/system-reboot.svg\n"
    echo -en "Logout\0icon\x1f/usr/share/icons/Nord-Icon/48x48/apps/system-log-out.svg\n"
    echo -en "Lock\0icon\x1f/usr/share/icons/Nord-Icon/48x48/apps/system-lock-screen.svg\n"
    echo -en "Suspend\0icon\x1f/usr/share/icons/Nord-Icon/48x48/apps/system-suspend.svg\n"
    echo -en "Hibernate\0icon\x1f/usr/share/icons/Nord-Icon/48x48/apps/system-hibernate.svg\n"
else
    if [ "$1" = "Shutdown" ]; then
        systemctl poweroff
    elif [ "$1" = "Logout" ]; then
        kill -9 -1
    elif [ "$1" = "Reboot" ]; then
        systemctl reboot
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    elif [ "$1" = "Lock" ]; then
        lock
    elif [ "$1" = "Hibernate" ]; then
        systemctl hibernate
    fi
fi