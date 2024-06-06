#!/usr/bin/env bash

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	[[ -z "$option_value" ]] && echo "$default_value" || echo "$option_value"
}

set_tmux_option() {
	local option=$1
	local value=$2
	tmux set-option -gq "$option" "$value"
}

get_info() {
	local context cluster namespace user
	context=$(kubectl config current-context 2>/dev/null)
	read -r cluster namespace user <<<$(_get_context_info $context)
	case "$1" in
		"context")
			echo "$context"
			;;
		"cluster")
			echo "$cluster"
			;;
		"namespace")
			echo "$namespace"
			;;
		"user")
			echo "$user"
			;;
	esac
}

_current_pane_command() {
	local pane_pid=$(tmux display-message -p "#{pane_pid}")

	# @TODO research, maybe `pgrep -flaP $pane_pid` is enough
	{ pgrep -flaP $pane_pid; ps -o command -p $pane_pid; } | xargs -I{} echo {}
}

_get_context_info() {
	local context_name=${1:-default}
	local context_info=$(kubectl config view --output jsonpath="{.contexts[?(@.name==\"$context_name\")].context}")

	local cluster=$(echo $context_info | grep -o '"cluster":"[^"]*' | grep -o '[^"]*$') # | yq '.cluster'
	local namespace=$(echo $context_info | grep -o '"namespace":"[^"]*' | grep -o '[^"]*$') # | yq '.namespace'
	local user=$(echo $context_info | grep -o '"user":"[^"]*' | grep -o '[^"]*$') # | yq '.user'

	echo "${cluster} ${namespace} ${user}"
}
