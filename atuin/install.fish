#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if command -q atuin
    link_file $DOTFILES_ROOT/atuin/config.toml $HOME/.config/atuin/config.toml backup
	    or abort brew

    atuin gen-completions --shell fish > ~/.config/fish/completions/atuin.fish
end



