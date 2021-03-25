#!/usr/bin/env bash

spot_script_dir=~/.config/eww/scripts/spotify

if [ ! -f "$spot_script_dir/track_list.txt" ]; then
	$spot_script_dir/show_my_saved_tracks.py > $spot_script_dir/track_list.txt
fi

status() {
	current=$(current_track.py | jq -r '.item.id')

	if grep -qF "$current" $spot_script_dir/track_list.txt; then
		echo ""
		liked=true
	else
		echo ""
		liked=false
	fi
}

change_status() {
	status
	if "$liked"; then
		$spot_script_dir/delete_track.py "$current"
		$spot_script_dir/show_my_saved_tracks.py > $spot_script_dir/track_list.txt
	else
		$spot_script_dir/save_track.py -t "$current"
		$spot_script_dir/show_my_saved_tracks.py > $spot_script_dir/track_list.txt
	fi
}

case "$1" in	
	--change|-c)
		change_status
		;;
	--status|-s|*)
		status
		;;
esac
