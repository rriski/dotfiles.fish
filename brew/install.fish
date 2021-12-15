#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/brew/Brewfile $HOME/Brewfile backup
	or abort brew
