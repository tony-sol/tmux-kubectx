#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${CURRENT_DIR}/utils/kube.sh"
source "${CURRENT_DIR}/utils/tmux.sh"

main() {
	PWD=$(get_tmux_message $pane_current_path) get_info user
}

main
