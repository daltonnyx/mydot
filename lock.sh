#!/bin/bash
if [ -n "$WAYLAND_DISPLAY" ]; then
  wall=$(find $HOME/Wallpapers/ -type f | shuf -n 1)
  killall swaylock -q
  swaylock -C /home/quy.truong/desktop-config/mydot/swaylock-macchiato.conf -f --fade-in 0.3 --clock --indicator --indicator-thickness 4 -i $wall
  #pgrep hyprlock || hyprlock
else
  BLANK='#00000000'
  CLEAR='#f4dbd622'
  DEFAULT='#24273acc'
  TEXT='#cad3f5ee'
  WRONG='#f4dbd6bb'
  VERIFYING='#8aadf4bb'

  i3lock \
    --insidever-color=$CLEAR \
    --ringver-color=$VERIFYING \
    \
    --insidewrong-color=$CLEAR \
    --ringwrong-color=$WRONG \
    \
    --inside-color=$BLANK \
    --ring-color=$BLANK \
    --line-color=$BLANK \
    --separator-color=$DEFAULT \
    \
    --verif-color=$TEXT \
    --wrong-color=$TEXT \
    --time-color=$TEXT \
    --date-color=$TEXT \
    --layout-color=$TEXT \
    --keyhl-color=$WRONG \
    --bshl-color=$WRONG \
    \
    --screen 1 \
    --blur 7 \
    --clock \
    --indicator \
    --time-str="%H:%M:%S" \
    --date-str="%A, %Y-%m-%d" \
    --keylayout 0
  # scrot -o /tmp/screenshot.png --silent
  # convert -scale 10% -blur 0x1.5 -resize 1000% /tmp/screenshot.png /tmp/screenshotblur.png
  # i3lock -i /tmp/screenshotblur.png
fi
