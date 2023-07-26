#!/usr/bin/env fish

if count ~/.local/share/fonts/Iosevka*.ttf > /dev/null ||
	count ~/Library/Fonts/Iosevka*.ttf > /dev/null
	exit 0
end

function install
    for font in Iosevka FiraCode
        curl -Lso /tmp/$font.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.tar.xz

        tar -xvf /tmp/$font.tar.xz -C $argv[1]
        rm /tmp/$font.tar.xz
    end
end

switch (uname)
case Darwin
	if command -qs brew
		brew bundle --file=$DOTFILES/fonts/Brewfile.fonts || true
	else
		install ~/Library/Fonts
	end
case '*'
	mkdir -p ~/.local/share/fonts/
		and install ~/.local/share/fonts/
	if command -qs fc-cache
		fc-cache -fv
	end
end
