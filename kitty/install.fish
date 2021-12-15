#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

mkdir -p $HOME/.config/kitty/
curl -sL https://raw.githubusercontent.com/dracula/kitty/master/dracula.conf -o $HOME/.config/kitty/dracula.conf
curl -sL https://raw.githubusercontent.com/trygveaa/kitty-kitten-search/master/search.py -o $HOME/.config/kitty/search.py
curl -sL https://raw.githubusercontent.com/trygveaa/kitty-kitten-search/master/scroll_mark.py -o $HOME/.config/kitty/scroll_mark.py

link_file $DOTFILES_ROOT/kitty/kitty.conf $HOME/.config/kitty/kitty.conf backup
	or abort kitty
