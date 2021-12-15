#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/htop/htoprc $HOME/.config/htop/htoprc backup
	or abort htoprc
