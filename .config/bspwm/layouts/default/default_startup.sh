#!/usr/bin/env bash

setsid -f chromium &
setsid -f geary &
setsid -f io.elementary.calendar &
setsid -f ptask &
setsid -f code &
#setsid -f code &
#setsid -f emacs &
#setsid -f emacs --name=Tasks --eval "(org-agenda)" &
setsid -f slack &
setsid -f nautilus &
