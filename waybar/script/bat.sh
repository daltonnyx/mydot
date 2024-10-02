#!/bin/bash

devices=('F3:2E:12:1C:32:F9' 'DE:F1:36:6E:87:E8')
icons=('󰥻' '󰍽')

for ((i = 0; i < ${#devices[@]}; i++)); do
  percent=$(bluetoothctl info ${devices[i]} | grep -oP "Battery Percentage: .+\(\K.+(?=\))")
  if [ -z "$percent" ]; then
    percent="0"
  fi
  echo -n "$percent% ${icons[i]}"
  if [ $i -ne $((${#devices[@]} - 1)) ]; then
    echo -n " "
  fi
done
