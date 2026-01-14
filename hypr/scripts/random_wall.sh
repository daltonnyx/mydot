#!/bin/bash

directory=~/Wallpapers/

if pgrep hyprpaper >/dev/null; then
  if [ -d "$directory" ]; then
    random_background=$(ls $directory/*.jpg | shuf -n 1)

    monitors=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
    for monitor in $monitors; do
      hyprctl hyprpaper wallpaper "$monitor, $random_background"
    done

  fi
fi
