#!/usr/bin/env fish

# To install asdf:
#
#     git clone https://github.com/asdf-vm/asdf.git ~/.asdf
#     asdf plugin add lua
#     asdf list all lua
#     asdf install lua 5.4.3
#     asdf global lua 5.4.3
#     lua -v
#
if ! test -f ~/.asdf/asdf.fish
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    source ~/.asdf/asdf.fish
end

for plugin in nodejs lua golang terraform python rust pipx
	if ! test -d ~/.asdf/plugins/$plugin
		asdf plugin add $plugin
	end
end
