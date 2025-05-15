#!/bin/bash

# Read the current platform profile
PROFILE_FILE="/sys/firmware/acpi/platform_profile"

# Check if the profile file exists and is readable
if [[ -r "$PROFILE_FILE" ]]; then
  CURRENT_PROFILE=$(cat "$PROFILE_FILE")

  ICON=""

  case "$CURRENT_PROFILE" in
  "low-power")
    ICON="󰡳" # Leaf icon for low power
    ;;
  "balanced")
    ICON="󰡵" # Gear icon for balanced
    ;;
  "performance")
    ICON="󰡴" # Rocket icon for performance
    ;;
  *)
    ICON="" # Question mark for unknown or other states
    ;;
  esac

  echo "$ICON"
else
  # Output an error icon or message if the file can't be read
  # Consider stderr for error messages if this script is part of a larger system
  echo "" # Warning icon if profile file is not accessible
  # Or, for a more descriptive error message:
  # echo "Error: Cannot read $PROFILE_FILE" >&2
fi
