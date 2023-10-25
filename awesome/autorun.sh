#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

xrandr --output eDP-1-1 --off
#run "xautolock" -time 15 -locker 'systemctl suspend'
#run "picom" -b
#run "ibus-daemon" -rxR
