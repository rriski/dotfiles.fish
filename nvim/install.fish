#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/nvim $HOME/.config/nvim backup
	or abort nvim
