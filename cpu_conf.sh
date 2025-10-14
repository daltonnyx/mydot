#!/bin/bash

# CPU Configuration Script
# Description: Configure CPU power management using cpupower utility
# Usage: ./cpu_conf.sh [powersave|balanced|fullload]
#
# Power States:
#   powersave - Minimum power consumption, reduced performance
#   balanced  - Balanced performance with selective CPU tuning
#   fullload  - Maximum performance, high power consumption
#
# Requirements: cpupower utility must be installed
# Run as: sudo ./cpu_conf.sh <state>

set -euo pipefail # Exit on error, undefined vars, pipe failures

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Script information
readonly SCRIPT_NAME="$(basename "$0")"
readonly VALID_STATES=("powersave" "balanced" "fullload")

# Logging functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1" >&2
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1" >&2
}

log_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1" >&2
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Display usage information
show_usage() {
  cat <<EOF
Usage: $SCRIPT_NAME <state>

Configure CPU power management with predefined states.

Available states:
  powersave    Set CPU to minimum power consumption mode
  balanced     Configure selective CPU cores for balanced performance
  fullload     Set CPU to maximum performance mode

Examples:
  sudo $SCRIPT_NAME powersave
  sudo $SCRIPT_NAME balanced
  sudo $SCRIPT_NAME fullload

Note: This script requires root privileges to modify CPU settings.
EOF
}

# Check if running as root
check_root() {
  if [[ $EUID -ne 0 ]]; then
    log_error "This script must be run as root (use sudo)"
    log_info "Try: sudo $SCRIPT_NAME $1"
    exit 1
  fi
}

# Check if cpupower is available
check_cpupower() {
  if ! command -v cpupower &>/dev/null; then
    log_error "cpupower utility is not installed"
    log_info "Install with: sudo apt install linux-cpupower (Debian/Ubuntu)"
    log_info "            or: sudo yum install kernel-tools (RHEL/CentOS)"
    exit 1
  fi
}

# Execute cpupower command with logging
execute_cpupower() {
  local cmd="$1"
  log_info "Executing: cpupower $cmd"

  if cpupower $cmd; then
    log_success "Command executed successfully"
  else
    log_error "Failed to execute: cpupower $cmd"
    return 1
  fi
}

# Validate state argument
validate_state() {
  local state="$1"
  local valid=false

  for valid_state in "${VALID_STATES[@]}"; do
    if [[ "$state" == "$valid_state" ]]; then
      valid=true
      break
    fi
  done

  if [[ "$valid" == false ]]; then
    log_error "Invalid state: '$state'"
    log_info "Valid states: ${VALID_STATES[*]}"
    show_usage
    exit 1
  fi
}

# Configure powersave state
configure_powersave() {
  log_info "Configuring CPU for powersave mode..."

  execute_cpupower "set -b 15"
  execute_cpupower "frequency-set -g powersave"

  log_success "CPU configured for powersave mode"
}

# Configure balanced state
configure_balanced() {
  log_info "Configuring CPU for balanced mode..."

  execute_cpupower "set -b 6"
  execute_cpupower "-c 8 set -b 0"
  execute_cpupower "-c 6 set -b 0"
  execute_cpupower "-c 4 set -b 0"
  execute_cpupower "-c 2 set -b 0"
  execute_cpupower "frequency-set -g powersave"
  execute_cpupower "-c 8 frequency-set -g performance"
  execute_cpupower "-c 6 frequency-set -g performance"
  execute_cpupower "-c 4 frequency-set -g performance"
  execute_cpupower "-c 2 frequency-set -g performance"

  log_success "CPU configured for balanced mode"
}

# Configure fullload state
configure_fullload() {
  log_info "Configuring CPU for fullload mode..."

  execute_cpupower "set -b 0"
  execute_cpupower "frequency-set -g performance"

  log_success "CPU configured for fullload mode"
}

# Display current CPU information
show_cpu_info() {
  log_info "Current CPU configuration:"
  echo "----------------------------------------"
  cpupower frequency-info 2>/dev/null | head -20 || log_warning "Unable to display CPU frequency info"
  echo "----------------------------------------"
}

# Main function
main() {
  # Check arguments
  if [[ $# -ne 1 ]]; then
    log_error "Missing required argument"
    show_usage
    exit 1
  fi

  local state="$1"

  # Convert to lowercase for case-insensitive comparison
  state=$(echo "$state" | tr '[:upper:]' '[:lower:]')

  # Validate inputs and prerequisites
  validate_state "$state"
  check_root "$state"
  check_cpupower

  # Show current state before changes
  log_info "Current CPU state before configuration:"
  show_cpu_info

  # Configure based on state
  case "$state" in
  powersave)
    configure_powersave
    ;;
  balanced)
    configure_balanced
    ;;
  fullload)
    configure_fullload
    ;;
  esac

  # Show final state
  log_info "CPU state after configuration:"
  show_cpu_info

  log_success "CPU configuration completed successfully"
}

# Handle script interruption
trap 'log_error "Script interrupted"; exit 130' INT TERM

# Execute main function with all arguments
main "$@"

