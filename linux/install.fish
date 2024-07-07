#!/usr/bin/env fish

if test (uname) != Linux
	exit
end

if not string match -q "*Ubuntu*" (lsb_release -d)
    exit
end

$DOTFILES/linux/deps.fish
$DOTFILES/linux/apps.fish
$DOTFILES/linux/keymap.fish
