#!/bin/bash
#

get_focused_monitor() {
  local monitor_name=""
  local resolution=""
  local is_focused=false

  while IFS= read -r line; do
    if [[ $line =~ ^Monitor\ ([^ ]+) ]]; then
      monitor_name="${BASH_REMATCH[1]}"
    elif [[ $line =~ ^([0-9]+)x([0-9]+)@ ]]; then
      resolution="${BASH_REMATCH[2]}"
    elif [[ $line =~ ^focused:\ yes ]]; then
      is_focused=true
      break
    elif [[ $line =~ ^focused:\ no ]]; then
      monitor_name=""
      resolution=""
    fi
  done < <(hyprctl monitors)

  if [[ $is_focused == true && -n $monitor_name ]]; then
    echo "$monitor_name $resolution"
  else
    echo "DP-1 1080"
  fi
}

get_ytdl_format() {
  local height=$1
  if [[ $height -ge 2160 ]]; then
    echo "bestvideo[height<=2160]+bestaudio/best[height<=2160]"
  elif [[ $height -ge 1440 ]]; then
    echo "bestvideo[height<=1440]+bestaudio/best[height<=1440]"
  elif [[ $height -ge 1080 ]]; then
    echo "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
  elif [[ $height -ge 720 ]]; then
    echo "bestvideo[height<=720]+bestaudio/best[height<=720]"
  else
    echo "bestvideo+bestaudio/best"
  fi
}

reset() {
  pkill -f "mpvpaper"
  pkill -f "mpv"
  if [[ $1 == "music" ]]; then
    return
  fi
  pkill -f "hyprpaper"
}

main() {
  local play_menu="󰐎 Play/Pause"
  local next_menu="󰒭 Next"
  local prev_menu="󰒮 Previous"
  local search_menu="  Search"
  local url_menu=" Play URL"
  local end_menu="󰈆 End"
  local music_menu="󰝚 Music"
  local play
  local option=$(echo -e "$play_menu\n$next_menu\n$prev_menu\n$search_menu\n$url_menu\n$music_menu\n$end_menu" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Youtube: ")

  read -r MONITOR RESOLUTION_HEIGHT <<<"$(get_focused_monitor)"
  local YT_FORMAT=$(get_ytdl_format "$RESOLUTION_HEIGHT")

  case $option in
  $play_menu)
    playerctl play-pause
    ;;
  $next_menu)
    playerctl next
    ;;
  $prev_menu)
    playerctl previous
    ;;
  $search_menu)
    local search=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Search: ")
    local i=0
    local titles=()
    local urls=()
    while IFS= read -r link; do
      if [ $((i % 2)) -eq 0 ]; then
        titles+=("$link")
      else
        urls+=("$link")
      fi
      i=$((i + 1))
    done < <(yt-dlp --get-url --get-title "https://www.youtube.com/results?search_query=$search" --no-warnings --skip-download --quiet --no-check-certificate --geo-bypass --playlist-end 15 --flat-playlist)
    local printedtitles=$(
      IFS=$'\n'
      echo "${titles[*]}"
    )
    local play=$(echo "$printedtitles" | rofi -theme-str "#listview {columns: 1;}" -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play: ")
    local index=0
    for title in "${titles[@]}"; do
      if [ "$title" == "$play" ]; then
        break
      fi
      index=$((index + 1))
    done
    if [ -z "$play" ]; then
      return
    fi

    reset

    mpvpaper --mpv-options="--no-audio-display --loop-playlist=inf --ytdl-raw-options=\"yes-playlist=\" --ytdl-format=\"$YT_FORMAT\"" "$MONITOR" "ytdl://ytsearch:$play"
    ;;
  $url_menu)
    local url=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "URL: ")
    if [ -z "$url" ]; then
      return
    fi
    reset
    mpvpaper --mpv-options="--no-audio-display --loop-playlist=inf --ytdl-raw-options=\"yes-playlist=\" --ytdl-format=\"$YT_FORMAT\"" "$MONITOR" "ytdl://$url"
    ;;
  $music_menu)
    local search=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Search: ")
    local i=0
    local titles=()
    local urls=()
    while IFS= read -r link; do
      if [ $((i % 2)) -eq 0 ]; then
        titles+=("$link")
      else
        urls+=("$link")
      fi
      i=$((i + 1))
    done < <(yt-dlp --get-url --get-title "https://www.youtube.com/results?search_query=$search" --no-warnings --skip-download --quiet --no-check-certificate --geo-bypass --playlist-end 15 --flat-playlist)
    local printedtitles=$(
      IFS=$'\n'
      echo "${titles[*]}"
    )
    local play=$(echo "$printedtitles" | rofi -theme catppuccin-macchiato -theme-str "#listview {columns: 1;}" -show-icons -icon-theme 'Papirus' -dmenu -p "Play: ")
    local index=0
    for title in "${titles[@]}"; do
      if [ "$title" == "$play" ]; then
        break
      fi
      index=$((index + 1))
    done
    reset music
    mpv --no-audio-display --loop-playlist=inf --ytdl-format="bestaudio" "${urls[$index]}"
    ;;
  $end_menu)
    reset
    pgrep hyprpaper || hyprpaper
    ;;
  *) ;;
  esac
}

main
