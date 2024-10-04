#!/bin/bash
#
reset() {
  pkill -f "mpvpaper"
  pkill -f "mpv"
  if [[ $1 == "music" ]]; then
    return
  fi
  pkill -f "hyprpaper"
}
main() {
  local play_menu="Play/Pause"
  local next_menu="Next"
  local prev_menu="Previous"
  local search_menu="Search"
  local end_menu="End"
  local music_menu="Music"
  local play
  local option=$(echo -e "$play_menu\n$next_menu\n$prev_menu\n$search_menu\n$music_menu\n$end_menu" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Youtube: ")

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
    reset

    mpvpaper --mpv-options="--no-audio-display --ytdl-format=\"bestvideo[height<1081]+bestaudio\"" HDMI-A-1 "ytdl://ytsearch:$play"
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
    mpv --no-audio-display --ytdl-format="bestaudio" "${urls[$index]}"
    ;;
  $end_menu)
    reset
    pgrep hyprpaper || hyprpaper
    ;;
  *) ;;
  esac
}

main
