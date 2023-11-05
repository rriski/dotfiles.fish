if status is-interactive
    if test (uname) = Darwin
        fish_add_path -pm (brew --prefix)/bin
    end

    fish_add_path -pm $DOTFILES/bin $HOME/.bin $HOME/.local/bin
end
