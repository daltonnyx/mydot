#!/bin/bash

export LC_ALL=C
while IFS= read -r pkg; do
  printf '%s %s\n' \
    "$(date -d "$(pacman -Qi "$pkg" | sed -n '/^Install Date/s/.* : //p')" +%Y-%m-%dT%H:%M:%S)" \
    "$pkg"
done < <(pacman -Qq) | sort -nk1
