#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/yabai/yabairc $HOME/.config/yabai/yabairc backup
	or abort tmux
