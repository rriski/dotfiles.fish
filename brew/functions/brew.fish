function brew -w brew
    switch $argv[1]
    case cleanup
        # See $DOTFILES/bin/brew-cleanup
        brew-cleanup
    case bump
        # See $DOTFILES/bin/brew-bump
        brew-bump
    case '*'
        if command -q brew
            command brew $argv
        end
    end
end
