#!/usr/bin/env fish

if command -qs restic
    restic generate --fish-completion ~/.config/fish/completions/restic.fish
end

