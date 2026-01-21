#!/usr/bin/env bash

get_info() {
	local context cluster namespace user
	IFS='#' read -r context cluster namespace user <<<"$(cd $PWD && command kubectl config view \
		--minify \
		--flatten \
		--output go-template='
	{{- with (index .contexts 0) -}}
	{{- .name }}#{{ .context.cluster }}#{{ or .context.namespace "default" }}#{{ .context.user -}}
	{{- end -}}' 2>/dev/null)"

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
