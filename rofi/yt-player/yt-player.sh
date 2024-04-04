#!/bin/bash
#

main() {
	local play_menu="Play now"
	local search_menu="Search"
	local end_menu="End"

	local option=$(echo -e "$play_menu\n$search_menu\n$end_menu" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Youtube: ")

	case $option in
	"Play now")
		local title=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play now: ")
		pkill -f "mpv-bg"
		mpv --no-audio-display --ytdl-format="bestvideo[height<2500]+bestaudio" "ytdl://ytsearch:$title" --loop --vo=gpu-next --wayland-app-id="mpv-bg"
		;;
	"Search")
		local search=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Search: ")
		local play=$(yt-dlp --get-title "ytsearch10:$search" --no-warnings --flat-playlist --skip-download --quiet --no-check-certificate --geo-bypass | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play: ")
		pkill -f "mpv-bg"
		mpv --no-audio-display --ytdl-format="bestvideo[height<2500]+bestaudio" "ytdl://ytsearch:$play" --loop --vo=gpu-next --wayland-app-id="mpv-bg"
		;;
	"End") pkill -f "mpv-bg" ;;
	*) ;;
	esac
}

main
