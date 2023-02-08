#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

mkdir -p $HOME/.config/kitty/
curl -sL https://raw.githubusercontent.com/dracula/kitty/master/dracula.conf -o $HOME/.config/kitty/dracula.conf

link_file $DOTFILES_ROOT/kitty/kitty.conf $HOME/.config/kitty/kitty.conf backup
	or abort kitty

link_file $DOTFILES_ROOT/kitty/kitty.app.png $HOME/.config/kitty/kitty.app.png backup
	or abort kitty
