#!/bin/bash

devices=('F3:2E:12:1C:33:00' 'DB:AB:CD:A7:78:26' '19:91:0B:11:57:59')
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
