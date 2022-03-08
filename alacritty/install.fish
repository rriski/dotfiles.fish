#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

curl -sL https://raw.githubusercontent.com/dracula/alacritty/master/dracula.yml -o ~/.config/alacritty/dracula.yml

link_file $DOTFILES_ROOT/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml backup
	or abort alacritty
