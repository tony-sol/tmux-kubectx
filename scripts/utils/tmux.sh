#!/usr/bin/env bash

declare -r kubectx_full_format='@kubectx-format'

declare -r kubectx_full='#{kubectx_full}'
declare -r kubectx_context='#{kubectx_context}'
declare -r kubectx_cluster='#{kubectx_cluster}'
declare -r kubectx_namespace='#{kubectx_namespace}'
declare -r kubectx_user='#{kubectx_user}'

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
