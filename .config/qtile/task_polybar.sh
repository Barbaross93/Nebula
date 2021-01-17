#!/bin/bash

most_urgent_desc=`task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next`
most_urgent_urgency=`task rc.verbose: rc.report.next.columns:urgency rc.report.next.labels:1 limit:1 next`
most_urgent_id=`task rc.verbose: rc.report.next.columns:id rc.report.next.labels:1 limit:1 next`
most_urgent_due=`task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next`
echo "$most_urgent_id" > /tmp/tw_polybar_id

if (( $(echo "$most_urgent_urgency >= 1" |bc -l) )); then
	if [[ "$most_urgent_due" == "" ]]; then
		echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> $most_urgent_desc "
	else
		echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> $most_urgent_desc · %{F#d9bb80}%{F-} $most_urgent_due "
	fi
else
	echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> No current task"
fi
