# Tmux Kubernetes Context

Tmux plugin that displaying current Kubernetes context, cluster, namespace and user.

![status-line](assets/status-line.png)
*Status line with [tmux-current-pane-hostname](https://github.com/Tony-Sol/tmux-current-pane-hostname) on the left side, tmux-kubectx and [tmux-mode-indicator](https://github.com/MunifTanjim/tmux-mode-indicator) on the right side*

## Usage

Place defined variable in `status-left`, `status-right` or `pane-border-format`:
- `#{kubectx_context}` will be the current context name, fetched by `kubectl config current-context`
- `#{kubectx_cluster}` will be the cluster name, defined in current context
- `#{kubectx_namespace}` will be the namespace, defined in current context
- `#{kubectx_user}` will be the user name, defined in current context
- `#{kubectx_full}` will be the full info (ctx name, cluster name, user name, namespace) about current context (see also [@kubectx-format](#kubectx-format))

### Example

```tmux
set -g status-right '#[bg=blue]#{kubectx_context}:#[bg=red]#{kubectx_namespace}#[default]'
```

## Installation

Prerequisites:
* [`bash`](https://www.gnu.org/software/bash/)
* [`kubectl`](https://github.com/kubernetes/kubectl) or [`yq`](https://github.com/mikefarah/yq)

### With [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```tmux
set -g @plugin "tony-sol/tmux-kubectx"
```

Hit `prefix + I` to fetch the plugin and source it.

### Manual

Clone the repo:

```shell
$ git clone https://github.com/tony-sol/tmux-kubectx ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```tmux
run-shell ~/clone/path/kubectx.tmux
```

Reload TMUX environment:

```shell
# type this in terminal
$ tmux source-file ~/.tmux.conf
```

## Configuration Options

### @kubectx-format

Template of `#{kubectx_full}` result. May contain following variables:
- `%{context}` - context name
- `%{cluster}` - cluster name
- `%{namespace}` - namespace
- `%{user}` - user name

```tmux
set -g @kubectx-format "%{context}/%{user}@%{cluster}:%{namespace}"
```
