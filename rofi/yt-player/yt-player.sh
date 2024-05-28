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
		pkill -f "mpvpaper"
		pkill -f "hyprpaper"
		mpvpaper --mpv-options="--no-audio-display --loop --ytdl-format=\"bestvideo[height<1081]+bestaudio\"" HDMI-A-1 "ytdl://ytsearch:$title"
		;;
	"Search")
		local search=$(rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Search: ")
		local play=$(yt-dlp --get-title "ytsearch10:$search" --no-warnings --flat-playlist --skip-download --quiet --no-check-certificate --geo-bypass | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Play: ")
		pkill -f "hyprpaper"
		pkill -f "mpvpaper"
		mpvpaper --mpv-options="--no-audio-display --loop --ytdl-format=\"bestvideo[height<1081]+bestaudio\"" HDMI-A-1 "ytdl://ytsearch:$play"
		;;
	"End")
		pkill -f "mpvpaper"
		hyprpaper
		;;
	*) ;;
	esac
}

main
