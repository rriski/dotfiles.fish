#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if command -q golangci-lint
    golangci-lint completion fish > ~/.config/fish/completions/golangci-lint.fish

    # Download "Golden" configuration from https://gist.github.com/maratori/47a4d00457a92aa426dbd48a18776322
    curl -o .golangci.yaml https://gist.githubusercontent.com/maratori/47a4d00457a92aa426dbd48a18776322/raw/43d6de07ca238a3994737171bd3fe2cd2b769bc0/.golangci.yml

    link_file $DOTFILES_ROOT/golang/.golangci.yaml $HOME/.golangci.yaml backup
        or abort brew

end
