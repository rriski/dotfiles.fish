#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/skhd/skhdrc $HOME/.config/skhd/skhdrc backup
	or abort skhd
