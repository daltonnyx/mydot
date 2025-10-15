#!/bin/bash

main() {
  local lock_menu="󰌾"
  local sleep_menu="󰒲 "
  local restart_menu="󰜉"
  local shutdown_menu="󰐥"

  local option=$(echo -e "$lock_menu\n$sleep_menu\n$restart_menu\n$shutdown_menu" | rofi -theme /home/quytruong/.config/rofi/power_mnt/shared/style.rasi -dmenu -p "Power Menu: ")

  case $option in
  $lock_menu)
    # Add your screen lock command here
    # For example: swaylock, i3lock, etc.
    lock_screen
    ;;
  $sleep_menu)
    systemctl suspend
    ;;
  $restart_menu)
    systemctl reboot
    ;;
  $shutdown_menu)
    systemctl poweroff
    ;;
  *) ;;
  esac
}

main
