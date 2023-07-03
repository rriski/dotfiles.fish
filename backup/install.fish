#!/usr/bin/env fish

if command -qs restic
    restic generate --fish-completion $__fish_config_dir/completions/restic.fish
end

