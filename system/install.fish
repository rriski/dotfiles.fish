#!/usr/bin/env fish
abbr -a less 'less -r'
abbr -a ll 'ls -lAh'
abbr -a la 'ls -A'

if test (uname -s) = "Darwin"
    alias rm="trash"
end
