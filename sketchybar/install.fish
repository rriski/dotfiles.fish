#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

link_file $DOTFILES_ROOT/sketchybar/sketchybarrc $HOME/.config/sketchybar/sketchybarrc backup
    or abort sketchybar

ln -sf $DOTFILES_ROOT/sketchybar/plugins/ $HOME/.config/sketchybar

