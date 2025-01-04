#!/bin/bash

handle() {
  case $line in
  submap*)
    submap="${line/submap>>/}"
    if [ "$submap" == "mousemove" ]; then
      hyprctl keyword input:repeat_delay 20 >/dev/null
      hyprctl keyword input:repeat_rate 100 >/dev/null
    else
      hyprctl keyword input:repeat_delay 400 >/dev/null
      hyprctl keyword input:repeat_rate 50 >/dev/null
    fi
    ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
