#!/bin/bash

most_urgent_id=`task +ACTIVE list 2>/dev/null </dev/null | sed -n '4 p' | awk '{print $1}'`
#most_urgent_due=`task rc.verbose: rc.report.next.columns:due.relative rc.report.next.labels:1 limit:1 next`
active_task=`task rc.gc=no rc.indent.report=4 rc.verbose= rc.report.next.columns=description.desc rc.report.next.labels= rc.defaultwidth=1000 next +ACTIVE 2>/dev/null </dev/null | sed -n '4 p' | awk '$1=$1'`
echo "$most_urgent_id" > /tmp/tw_polybar_id

if [[ -n "$active_task" ]]; then
		echo " $active_task"
else	
	echo " No current task"
fi


