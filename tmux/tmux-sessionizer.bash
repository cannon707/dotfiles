#!/usr/bin/env bash
# simplified version of ThePrimeagen tmux sessionizer
# https://github.com/ThePrimeagen/tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/git/ ~/.config/nvim -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
	tmux new-session -ds $selected_name -c $selected

	project_type="plain"
	if [[ -f "$selected/package.json" ]]; then
		project_type="node"
	elif [[ -f "$selected/pom.xml" ]]; then
		project_type="maven"
	elif [[ -f "$selected/${selected_name}-parent/pom.xml" ]]; then
		project_type="maven"
		project_root="$selected/${selected_name}-parent"
	fi
	
	case "$project_type" in
	node)
		tmux rename-window -t "$selected_name:1" vim
		tmux send-keys -t "$selected_name:1" "vim ." Enter
		tmux new-window -t "$selected_name" -n lazygit -c "$selected" bash -lc 'lazygit; exec bash'
		tmux new-window -t "$selected_name" -n lazygit -c shell -c "$selected"
		tmux select-window -t "$selected_name:1"
		;;
	maven)
		tmux rename-window -t "$selected_name:1" vim
		tmux send-keys -t "$selected_name:1" "vim ." Enter
		tmux new-window -t "$selected_name" -n lazygit -c "$selected" bash -lc 'lazygit; exec bash'
		tmux new-window -t "$selected_name" -n lazygit -c shell -c "$selected"
		tmux select-window -t "$selected_name:1"
		;;
	esac
fi

tmux switch-client -t $selected_name

