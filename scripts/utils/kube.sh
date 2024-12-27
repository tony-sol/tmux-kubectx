#!/usr/bin/env bash

__get_info() {
	local context=$(command kubectl config current-context 2>/dev/null)
	[[ -z "$context" ]] && return

	local context_info=$(command kubectl config view --output jsonpath="{.contexts[?(@.name==\"$context\")].context}")

	local cluster=$(echo $context_info | grep -o '"cluster":"[^"]*' | grep -o '[^"]*$') # | yq '.cluster'
	local namespace=$(echo $context_info | grep -o '"namespace":"[^"]*' | grep -o '[^"]*$') # | yq '.namespace'
	local user=$(echo $context_info | grep -o '"user":"[^"]*' | grep -o '[^"]*$') # | yq '.user'

	namespace="${namespace:-default}"

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
		"")
			echo "$context#$cluster#$namespace#$user"
			;;
	esac
}

get_info() {
	__get_info
}

get_cluster() {
	__get_info cluster
}

get_context() {
	__get_info context
}

get_namespace() {
	__get_info namespace
}

get_user() {
	__get_info user
}
