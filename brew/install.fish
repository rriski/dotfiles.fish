#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if command -q brew
	link_file $DOTFILES_ROOT/brew/Brewfile $HOME/Brewfile backup
	    or abort brew
end
