#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if ! test -d $DOTFILES/tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $DOTFILES/tmux/plugins/tpm
end

link_file $DOTFILES_ROOT/tmux $HOME/.config/tmux backup
	or abort tmux
