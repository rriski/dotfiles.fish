#!/usr/bin/env fish

if test (uname) != Darwin
	exit
end

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/skhd/skhdrc $HOME/.config/skhd/skhdrc backup
	or abort skhd
