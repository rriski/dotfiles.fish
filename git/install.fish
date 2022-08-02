#!/usr/bin/env fish

if command -qs gh
	abbr -a 'grv' 'gh repo view -w'
	abbr -a 'gpv' 'gh pr view -w'
end

set TEMPLATES_DIR "$HOME/.git-templates/hooks"
if ! test -d "$TEMPLATES_DIR"
	mkdir -p "$TEMPLATES_DIR"
end

for hook in $DOTFILES/git/.git-templates/*
	ln -sf $hook $TEMPLATES_DIR/(basename $hook)
end