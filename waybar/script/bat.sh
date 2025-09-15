#!/bin/bash

devices=('F3:2E:12:1C:32:FD' 'F6:BD:34:3E:45:0F' 'F4:4E:FD:31:ED:9C')
icons=('󰥻' '󰍽' '')

for ((i = 0; i < ${#devices[@]}; i++)); do
  percent=$(bluetoothctl info ${devices[i]} | grep -oP "Battery Percentage: .+\(\K.+(?=\))")
  if [ -z "$percent" ]; then
    percent="0"
  fi
  if [ "$percent" -eq "0" ]; then
    continue
  fi
  echo -n "$percent% ${icons[i]}"
  if [ $i -ne $((${#devices[@]} - 1)) ]; then
    echo -n " "
  fi
done
