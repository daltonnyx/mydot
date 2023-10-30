#!/bin/bash
scrot -o /tmp/screenshot.png --silent
convert -scale 10% -blur 0x1.5 -resize 1000% /tmp/screenshot.png /tmp/screenshotblur.png
if [ -n "$WAYLAND_DISPLAY" ]; then
	pgrep swaylock || swaylock -C /home/quy.truong/desktop-config/mydot/swaylock-macchiato.conf -f --screenshots --clock --indicator --fade-in 0.1 --effect-blur 7x7 --indicator-thickness 4 #-i /home/quy.truong/desktop-config/mydot/awesome/themes/powerarrow-dark/wall.png
else
	scrot -o /tmp/screenshot.png --silent
	convert -scale 10% -blur 0x1.5 -resize 1000% /tmp/screenshot.png /tmp/screenshotblur.png
	i3lock -i /tmp/screenshotblur.png
fi
