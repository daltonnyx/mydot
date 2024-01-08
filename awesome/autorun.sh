#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

xrandr --output eDP-1-1 --off
xset r rate 400 50
#run "xautolock" -time 15 -locker 'systemctl suspend'
#run "picom" -b
#run "ibus-daemon" -rxR
run clipcatd
