# Tmux Kubernetes Context

Tmux plugin that displaying current Kubernetes context, cluster, namespace and user.

![status-line](assets/status-line.png)
*Status line with [tmux-current-pane-hostname](https://github.com/Tony-Sol/tmux-current-pane-hostname) on the left side, tmux-kubectx and [tmux-mode-indicator](https://github.com/MunifTanjim/tmux-mode-indicator) on the right side*

## Usage

Place defined variable in `status-left`,`status-right` or `pane-border-format`:
- `#{kube_context}` will be the current context name, fetched by `kubectl config current-context`
- `#{kube_cluster}` will be the cluster name, defined in current context
- `#{kube_namespace}` will be the namespace, defined in current context
- `#{kube_user}` will be the user name, defined in current context

### Example

```tmux
set -g status-right '#[bg=blue]#{kube_context}:#[bg=red]#{kube_namespace}#[default]'
```

## Installation

### With [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```tmux
set -g @plugin "tony-sol/tmux-kubectx"
```

Hit `prefix + I` to fetch the plugin and source it.

### Manual

Clone the repo:

```bash
$ git clone https://github.com/tony-sol/tmux-kubectx ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```tmux
run-shell ~/clone/path/kubectx.tmux
```

Reload TMUX environment:

```bash
# type this in terminal
$ tmux source-file ~/.tmux.conf
```
