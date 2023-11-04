#!/usr/bin/env fish

if test (uname) != Darwin
	exit
end

source $DOTFILES/script/utils.fish

if command -q brew
	link_file $DOTFILES_ROOT/brew/Brewfile $HOME/Brewfile backup
	    or abort brew
end
