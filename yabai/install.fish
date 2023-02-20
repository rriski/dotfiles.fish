#!/usr/bin/env fish

if test (uname) != Darwin
	exit
end

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/yabai/yabairc $HOME/.config/yabai/yabairc backup
	or abort yabai
