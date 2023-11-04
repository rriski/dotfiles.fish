#!/usr/bin/env fish

set -Ux EDITOR vim
set -Ux VISUAL $EDITOR
set -Ux WEDITOR code
set -Ux TERM xterm-kitty
set -Ux XDG_CONFIG_HOME $HOME/.config

set -Ux DOTFILES $HOME/.dotfiles.fish
set -Ux PROJECTS $HOME/code

fish_add_path -pm $DOTFILES/bin $HOME/.bin $HOME/.local/bin

if test (uname) = Darwin
	fish_add_path -pm (brew --prefix)/bin
end

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f $__fish_config_dir/conf.d/(basename $f)
end

if test -f ~/.localrc.fish
	ln -sf ~/.localrc.fish $__fish_config_dir/conf.d/localrc.fish
end
