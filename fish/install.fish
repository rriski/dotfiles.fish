#!/usr/bin/env fish

# Unset greeting
set -U fish_greeting

# Use vi key bindings
# insert mode: line
# normal mode: block
# visual mode: block
# replace mode: underscore
set -U fish_key_bindings fish_vi_key_bindings
set -U fish_cursor_default block
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore
set -U fish_cursor_replace underscore
