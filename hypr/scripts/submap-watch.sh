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
  case $line in
  destroyworkspacev2*)
    workspace="${line/destroyworkspacev2>>/}"
    if [ "$workspace" == "-99,special:special" ]; then
      hyprctl dispatch submap reset
    fi
    ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
