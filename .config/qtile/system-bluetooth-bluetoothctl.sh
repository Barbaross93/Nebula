#!/bin/sh

bluetooth_print() {
    #bluetoothctl | while read -r; do
        if [ "$(bluetoothctl show | grep Powered | xargs printf "%s" "$1")" = "Powered:yes" ]; then       
            #printf ''
	        printf "<span font_desc='Font Awesome 5 Brands' foreground='#81a1c1'> </span>"

            devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
            counter=0

            echo "$devices_paired" | while read -r line; do
                device_info=$(bluetoothctl info "$line")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

                    if [ $counter -gt 0 ]; then
                        printf ", %s" "<span foreground='#81a1c1'>$device_alias</span>"
                    else
                        printf "%s" "<span foreground='#81a1c1'>$device_alias</span>"
                    fi

                    counter=$((counter + 1))
                fi

                printf '\n'
                #break
            done
        else
            #echo "%{F#9a998e}%{F-} Off"
            printf "<span font_desc='Font Awesome 5 Brands' foreground='#4c566a'></span> <span foreground='#4c566a'>Off</span>"
        fi
    #done
}

bluetooth_toggle() {
	 if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac

