#!/bin/bash

tmux has-session -t yai 2>/dev/null

if [ $? != 0 ]; then
  tmux new -d -s yai -n yai
  tmux send-keys -t yai:yai "tmux set status on" Enter
  tmux send-keys -t yai:yai "clear" Enter

fi
#
# if ! pgrep -x "yai" >/dev/null; then
# 	tmux send-keys -t yai:yai "yai -c" Enter
# fi

pkill -f 'kitty --class kitty-floating' || kitty --class kitty-floating -o confirm_os_window_close=0 -e -- tmux new -As yai -n yai
