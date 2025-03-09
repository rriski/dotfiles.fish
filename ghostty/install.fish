#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

set CONFIG_DIR $HOME/.config/ghostty

if command -qs ghostty
    link_file $DOTFILES_ROOT/ghostty/config $CONFIG_DIR/config backup
        or abort ghostty

    # Install Dracula theme for Ghostty
    if not test -d $CONFIG_DIR/themes/dracula
        git clone https://github.com/dracula/ghostty.git $CONFIG_DIR/themes
    end
end


