#!/usr/bin/env fish

source $DOTFILES/script/utils.fish

if command -q golangci-lint
  golangci-lint completion fish > ~/.config/fish/completions/golangci-lint.fish
end
