#!/usr/bin/env fish
set -Ux EDITOR vim
set -Ux VISUAL $EDITOR
set -Ux WEDITOR code
set -Ux TERM xterm-256color

set -Ux DOTFILES ~/.dotfiles.fish
set -Ux PROJECTS ~/work

set -Ua fish_user_paths $DOTFILES/bin $HOME/.bin $HOME/.local/bin

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f ~/.config/fish/conf.d/(basename $f)
end

if test -f ~/.localrc.fish
	ln -sf ~/.localrc.fish ~/.config/fish/conf.d/localrc.fish
end
