#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if ! test -d $DOTFILES/tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $DOTFILES/tmux/plugins/tpm
end

link_file $DOTFILES_ROOT/tmux/sh/smart-kill-pane $HOME/.config/tmux/sh/smart-kill-pane backup
	or abort tmux
link_file $DOTFILES_ROOT/tmux/tmux.conf $HOME/.config/tmux/tmux.conf backup
	or abort tmux
