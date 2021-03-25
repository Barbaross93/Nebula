#!/bin/bash

#most_urgent_desc=`task rc.verbose: rc.report.next.columns:description rc.report.next.labels:1 limit:1 next`
#most_urgent_urgency=`task rc.verbose: rc.report.next.columns:urgency rc.report.next.labels:1 limit:1 next`
#most_urgent_id=`task rc.verbose: rc.report.next.columns:id rc.report.next.labels:1 limit:1 next`
most_urgent_id=`task +ACTIVE list | sed -n '4 p' | awk '{print $1}'`
#most_urgent_due=`task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next`
active_task=`task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=description.desc rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1'`
echo "$most_urgent_id" > /tmp/tw_polybar_id

#if (( $(echo "$most_urgent_urgency >= 1" |bc -l) )); then
if [[ -n "$active_task" ]]; then
	#if [[ "$most_urgent_due" == "" ]]; then
		echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> $active_task "
	#else
#		echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> $most_urgent_desc · %{F#d9bb80}%{F-} $most_urgent_due "

	#fi
else
	echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> No current task"
fi


#if grep -q "(A)" ~/.todo/todo.txt; then
#	task=$(todo.sh ls | head -n1 | cut -d'@' -f-1 | cut -d' ' -f3-)
#	echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> $task "
#else
#	echo "<span font_desc='Font Awesome 5 Free Solid' foreground='#d08770'></span> No current task "
#fi
