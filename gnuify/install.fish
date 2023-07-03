#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if test (uname) != Darwin
	exit
end

if ! type -q brew
	exit
end

brew bundle --file=$DOTFILES/gnuify/Brewfile.gnu

