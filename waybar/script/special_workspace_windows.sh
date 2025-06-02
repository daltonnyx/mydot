#!/bin/bash

# Get the output from hyprctl workspaces and process it
special_workspace=$(hyprctl workspaces | grep -A5 "workspace ID -99")

# Check if the special workspace exists
if [ -z "$special_workspace" ]; then
  echo "󰕮 0" # Using a nerd font icon for window with 0 windows
  exit 0
fi

# Extract the number of windows
windows=$(echo "$special_workspace" | grep "windows:" | awk '{print $2}')

# Output the result with a nerd font icon
# Using  (Unicode: f2d0) for window icon from Nerd Fonts
echo "󰕮 $windows"
