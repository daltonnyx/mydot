#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

#run "xautolock" -time 15 -locker 'systemctl suspend'
#run "picom" -b
#run "ibus-daemon" -rxR
