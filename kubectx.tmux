#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${CURRENT_DIR}/scripts/utils/tmux.sh"

# Create map placeholders to handle scripts
# to provide one handler for multiple placeholders.
# Use '//' as separator, due to unix limitation in filenames
placeholders_to_scripts=(
	"$kubectx_full//#(${CURRENT_DIR}/scripts/all.sh)"
	"$kubectx_context//#(${CURRENT_DIR}/scripts/context.sh)"
	"$kubectx_cluster//#(${CURRENT_DIR}/scripts/cluster.sh)"
	"$kubectx_namespace//#(${CURRENT_DIR}/scripts/namespace.sh)"
	"$kubectx_user//#(${CURRENT_DIR}/scripts/user.sh)")

do_interpolation() {
	local interpolated=$1
	for assignment in ${placeholders_to_scripts[@]}; do
		# ${assignment%\/\/*} - remove from // til EOL
		local placeholder="${assignment%\/\/*}"
		# ${assignment#*\/\/} - remove from BOL til //
		local script="${assignment#*\/\/}"
		# ${interpolated//A/B} - replace all occurrences of A in interpolated with B
		interpolated="${interpolated//${placeholder}/${script//[[:space:]]/\\ }}"
	done
	echo "$interpolated"
}

main() {
	local option option_value new_option_value
	for option in "status-right" "status-left" "pane-border-format"; do
		option_value=$(get_tmux_option "$option")
		new_option_value=$(do_interpolation "$option_value")
		set_tmux_option "$option" "$new_option_value"
	done;
}

main
