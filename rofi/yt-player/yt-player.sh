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
  local play_menu="Play now"
  local search_menu="Search"
  local end_menu="End"
  local music_menu="Music"
  local option=$(echo -e "$play_menu\n$search_menu\n$music_menu\n$end_menu" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Youtube: ")

  case $option in
  $play_menu)
    local title=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play now: ")
    reset
    mpvpaper --mpv-options="--no-audio-display --loop --ytdl-format=\"bestvideo[height<1081]+bestaudio\"" HDMI-A-1 "ytdl://ytsearch:$title"
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
    local play=$(echo "$printedtitles" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play: ")
    local index=0
    for title in "${titles[@]}"; do
      if [ "$title" == "$play" ]; then
        break
      fi
      index=$((index + 1))
    done
    reset

    mpvpaper --mpv-options="--no-audio-display --loop --ytdl-format=\"bestvideo[height<1081]+bestaudio\"" HDMI-A-1 "ytdl://ytsearch:$play"
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
    local play=$(echo "$printedtitles" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play: ")
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
