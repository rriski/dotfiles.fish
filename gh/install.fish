#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if command -qs gh
	gh config set git_protocol ssh

	for ext in mislav/gh-branch vilmibm/gh-user-status dlvhdr/gh-dash
		gh extension install $ext || true
	end
end

link_file $DOTFILES_ROOT/gh/gh-dash/config.yml $HOME/.config/gh-dash/config.yml backup
	or abort gh

