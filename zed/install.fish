#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/zed/settings.json $HOME/.config/zed/settings.json backup
	or abort zed

link_file $DOTFILES_ROOT/zed/keymap.json $HOME/.config/zed/keymap.json backup
	or abort zed

link_file $DOTFILES_ROOT/zed/themes/dracula.json $HOME/.config/zed/themes/dracula.json backup
	or abort zed
