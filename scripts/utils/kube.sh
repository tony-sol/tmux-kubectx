#!/usr/bin/env bash

_get_info() {
	local context=$(command kubectl config current-context 2>/dev/null)

	local context_info=$(command kubectl config view --output jsonpath="{.contexts[?(@.name==\"$context\")].context}")

	local cluster=$(echo $context_info | grep -o '"cluster":"[^"]*' | grep -o '[^"]*$') # | yq '.cluster'
	local namespace=$(echo $context_info | grep -o '"namespace":"[^"]*' | grep -o '[^"]*$') # | yq '.namespace'
	local user=$(echo $context_info | grep -o '"user":"[^"]*' | grep -o '[^"]*$') # | yq '.user'

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
			echo "$context $cluster $namespace $user"
			;;
	esac
}

get_info() {
	_get_info
}

get_cluster() {
	_get_info cluster
}

get_context() {
	_get_info context
}

get_namespace() {
	_get_info namespace
}

get_user() {
	_get_info user
}
