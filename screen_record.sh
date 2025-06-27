#!/usr/bin/env bash
#
# wf-grab – screen-record a region or the focused window on Wayland
#
# REQUIREMENTS
#   wf-recorder – https://github.com/ammen99/wf-recorder
#   slurp       – https://github.com/emersion/slurp
#   jq          – for JSON parsing when using “focused-window” mode
#   swaymsg     – ships with sway (or use `wayland-info` / `hyprctl` and adapt)
#
# USAGE
#   wf-grab              # select region with mouse, save to ./recording_<date>.mp4
#   wf-grab -f           # record the focused window
#   wf-grab -a <source>  # also record audio (PulseAudio / PipeWire source name)
#   wf-grab -c libx265   # pick a different video codec (passed to wf-recorder)
#   wf-grab -h           # help
#
# Hit Ctrl-C to stop recording.  The final file name is printed afterwards.
#
set -euo pipefail

###############################################################################
#                               option parsing                                #
###############################################################################
record_focused=false
audio_source=""
codec="libx264"

usage() {
  cat <<EOF
Usage: $(basename "$0") [options] [output_file]

Options
  -f            Record the currently focused window instead of drawing a region
  -a <source>   Pipe a PulseAudio/PipeWire source into the recording
                (e.g. "alsa_output.pci-0000_00_1f.3.analog-stereo.monitor")
  -c <codec>    Video codec for wf-recorder (default: $codec)
  -h            Show this help
EOF
  exit 0
}

while getopts ":fa:c:h" opt; do
  case "$opt" in
  f) record_focused=true ;;
  a) audio_source="$OPTARG" ;;
  c) codec="$OPTARG" ;;
  h) usage ;;
  *) usage ;;
  esac
done
shift $((OPTIND - 1))

###############################################################################
#                             determine geometry                              #
###############################################################################
outfile=${1:-"recording_$(date +%F_%H-%M-%S).mp4"}

if $record_focused; then
  # Uses sway's IPC; works under sway and most wlroots compositors.
  # Feel free to replace with `hyprctl activewindow -j` etc. on Hyprland.
  region=$(swaymsg -t get_tree | jq -r \
    '.. | select(.focused? == true) \
           | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)"')
  if [[ -z "$region" ]]; then
    echo "Could not detect a focused window – falling back to interactive mode."
  fi
fi

if [[ -z "${region:-}" ]]; then # no focused geometry or not requested
  echo "Select a region …"
  region=$(slurp) || {
    echo "Selection aborted."
    exit 1
  }
fi

###############################################################################
#                           launch wf-recorder                                #
###############################################################################
cmd=(wf-recorder -g "$region" -f "$outfile" -c "$codec")
[[ -n "$audio_source" ]] && cmd+=(-a "$audio_source")

echo "Recording → $outfile  |  Region: $region"
echo "Press Ctrl-C to stop …"
"${cmd[@]}"

echo "Saved to $outfile"
