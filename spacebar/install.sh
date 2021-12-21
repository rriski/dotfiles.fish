#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/spacebar/spacebarrc $HOME/.config/spacebar/spacebarrc backup
	or abort spacebar
