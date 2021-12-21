#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

test -f ~/.ssh/config || touch ~/.ssh/config

grep -q "Include ~/.ssh/config.dotfiles" ~/.ssh/config ||
	echo "Include ~/.ssh/config.dotfiles" >> ~/.ssh/config

link_file $DOTFILES_ROOT/ssh/config.dotfiles $HOME/.ssh/config.dotfiles backup
	or abort ssh
