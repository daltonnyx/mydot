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

  FIRST_TEMP=$(cat /proc/acpi/ibm/thermal 2>/dev/null | awk '{print $2}')

  # Output the icon. If FIRST_TEMP has a value, append it.
  if [[ -n "$FIRST_TEMP" ]]; then
    printf "{\"text\": \"$ICON $FIRST_TEMP°C\", \"class\": \"$CURRENT_PROFILE\"}"
  else
    # If FIRST_TEMP is empty (e.g., temp file not found or awk failed), just print the icon
    printf "{\"text\":\"$ICON\"}"
  fi

else
  # Output an error icon or message if the file can't be read
  # Consider stderr for error messages if this script is part of a larger system
  ICON="" # Warning icon if profile file is not accessible
  printf "{\"text\":\"$ICON\"}"
  # Or, for a more descriptive error message:
  # echo "Error: Cannot read $PROFILE_FILE" >&2
fi
