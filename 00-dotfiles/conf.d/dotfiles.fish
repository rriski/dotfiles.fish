if status is-interactive
    if test (uname) = Darwin
        fish_add_path -am (brew --prefix)/bin
    end

    fish_add_path -am $DOTFILES/bin $HOME/.bin $HOME/.local/bin
end
