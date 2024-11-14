#!/bin/bash

directory=~/Wallpapers/
monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

if pgrep hyprpaper >/dev/null; then
  if [ -d "$directory" ]; then
    random_background=$(ls $directory/*.jpg | shuf -n 1)

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload $random_background
    hyprctl hyprpaper wallpaper "$monitor, $random_background"

  fi
fi
