function brew -w brew
    if ! command -qs brew
        echo "brew is not installed"
        return
    end
    switch $argv[1]
    case cleanup
        # See $DOTFILES/bin/brew-cleanup
        brew-cleanup
    case bump
        # See $DOTFILES/bin/brew-bump
        brew-bump
    case '*'
            command brew $argv
    end
end
