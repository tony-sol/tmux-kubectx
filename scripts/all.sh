#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/utils/kube.sh
source $CURRENT_DIR/utils/tmux.sh

main() {
	local context cluster namespace user
	read -r context cluster namespace user <<<$(get_info)
	# eval is literaly evil, so i won't use this
	# eval echo $(get_tmux_option $kubectx_full_format)
	get_tmux_option $kubectx_full_format | sed \
		-e "s/%{context}/$context/" \
		-e "s/%{cluster}/$cluster/" \
		-e "s/%{namespace}/$namespace/" \
		-e "s/%{user}/$user/"
}

main

