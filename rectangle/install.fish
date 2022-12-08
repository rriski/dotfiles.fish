#!/usr/bin/env fish
switch (uname)
case Darwin
	mkdir -p "$HOME/Library/Application Support/Rectangle/"
	ln -sf $DOTFILES/rectangle/RectangleConfig.json "$HOME/Library/Application Support/Rectangle/RectangleConfig.json"
end
