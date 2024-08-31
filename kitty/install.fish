#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

mkdir -p $HOME/.config/kitty/
curl -sL https://raw.githubusercontent.com/dracula/kitty/master/dracula.conf -o $HOME/.config/kitty/dracula.conf

link_file $DOTFILES_ROOT/kitty/kitty.conf $HOME/.config/kitty/kitty.conf backup
	or abort kitty

link_file $DOTFILES_ROOT/kitty/kitty.app.png $HOME/.config/kitty/kitty.app.png backup
	or abort kitty

# Download xterm-kitty terminfo
curl -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/kovidgoyal/kitty/contents/terminfo/kitty.terminfo \
    | jq -r '.content' \
    | base64 -d \
    | tic -x -o ~/.terminfo -
