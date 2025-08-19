#!/usr/bin/env bash

__get_info() {
	local context cluster namespace user
	# @perf parsing KUBECONFIG as just yaml via yq is PROBABLY faster than kubectl calls
	if command -v yq 2>&1 >/dev/null; then
		IFS='#' read -r context cluster namespace user <<<"$(command yq \
			--unwrapScalar '
		.current-context as $context
		| .contexts[]
		| select(.name==$context)
		| "\(.name)#\(.context.cluster)#\(.context.namespace // \"default\")#\(.context.user)"
		' "${KUBECONFIG:-~/.kube/config}" 2>/dev/null)"
	else
		IFS='#' read -r context cluster namespace user <<<"$(command kubectl config view \
			--minify \
			--flatten \
			--output go-template='
		{{- $name := (index .contexts 0).name -}}
		{{- with (index .contexts 0).context -}}
		{{- $name }}#{{ .cluster }}#{{ or .namespace "default" }}#{{ .user -}}
		{{- end -}}' 2>/dev/null)"
	fi

	[[ -z "$context" ]] && return

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
