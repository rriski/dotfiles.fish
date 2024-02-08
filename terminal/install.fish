#!/usr/bin/env fish

if test (uname) != Darwin
	exit
end

open -a Terminal.app "$DOTFILES/terminal/Dracula.terminal"
defaults write com.apple.terminal "Default Window Settings" -string "Dracula"
defaults write com.apple.terminal "Startup Window Settings" -string "Dracula"
