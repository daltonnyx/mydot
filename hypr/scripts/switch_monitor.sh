#!/bin/bash

#get the argument as the input for action, couldbe internal or external
action=$1

# Check the action and perform corresponding tasks
if [ "$action" == "internal" ]; then
  hyprctl keyword monitor eDP-1,preferred,auto,1
  hyprctl keyword monitor HDMI-A-1,disable
  # Add your internal action commands here
elif [ "$action" == "external" ]; then
  other_monitor=$(hyprctl monitors | grep HDMI-A-1)
  if [ -z "$other_monitor" ]; then
    notify-send "No external monitor found"
    exit 1
  fi
  hyprctl keyword monitor HDMI-A-1,preferred,auto,1
  hyprctl keyword monitor eDP-1,disable
else
  echo "No valid action provided"
fi
