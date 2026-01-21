#!/usr/bin/env bash

declare -r kubectx_full_format='@kubectx-format'

declare -r kubectx_full='#{kubectx_full}'
declare -r kubectx_context='#{kubectx_context}'
declare -r kubectx_cluster='#{kubectx_cluster}'
declare -r kubectx_namespace='#{kubectx_namespace}'
declare -r kubectx_user='#{kubectx_user}'

declare -r pane_current_path='#{pane_current_path}'

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	[[ -z "$option_value" ]] && echo "$default_value" || echo "$option_value"
}

# @todo combine with `get_tmux_option`
get_tmux_message() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux display-message -pF "$option")
	[[ -z "$option_value" ]] && echo "$default_value" || echo "$option_value"
}

set_tmux_option() {
	local option=$1
	local value=$2
	tmux set-option -gq "$option" "$value"
}
