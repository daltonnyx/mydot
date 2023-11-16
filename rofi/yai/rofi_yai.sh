#!/bin/bash

AUTHOR=$(whoami)
QUESTION_HISTORY="$HOME/.yai_history"
YAI_TMUX='kitty --class kitty-floating -e nvim'

get_questions() {
	if [ ! -f "${QUESTION_HISTORY}" ]; then
		touch "$QUESTION_HISTORY"
	fi
	cat "$QUESTION_HISTORY"
}

edit_note() {
	note_location=$1
	$YAI_TMUX "$note_location"
}

delete_note() {
	local note=$1
	local action=$(echo -e "Yes\nNo" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Are you sure you want to delete $note? ")

	case $action in
	"Yes")
		rm "$NOTES_FOLDER/$note"
		main
		;;
	"No")
		main
		;;
	esac
}

note_context() {
	local note=$1
	local note_location="$NOTES_FOLDER/$note"
	local action=$(echo -e "Edit\nDelete" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "$note > ")
	case $action in
	"Edit")
		edit_note "$note_location"
		;;
	"Delete")
		delete_note "$note"
		;;

	esac
}

new_note() {
	local title=$(echo -e "Cancel" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Input title: ")

	case "$title" in
	"Cancel")
		main
		;;
	*)
		local file=$(echo "$title" | sed 's/ /_/g;s/\(.*\)/\L\1/g')
		local template=$(
			cat <<-END
				---
				title: $title
				date: $(date --rfc-3339=seconds)
				author: $AUTHOR
				---

				# $title
			END
		)

		note_location="$NOTES_FOLDER/$file.md"
		if [ "$title" != "" ]; then
			echo "$template" >"$note_location" | edit_note "$note_location"
		fi
		;;
	esac
}

main() {
	local all_question="$(get_questions)"

	local question=$(echo -e "$all_question" | rofi -theme catppuccin-macchiato -show-icons -icon-theme 'Papirus' -dmenu -p "Yai: ")

	case $question in
	"New")
		new_note
		;;
	"") ;;
	*)
		note_context "$note"
		;;
	esac
}

main
