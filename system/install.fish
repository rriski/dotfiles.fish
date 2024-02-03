#!/usr/bin/env fish
abbr -a less 'less -r'
abbr -a l 'ls -lAh'
abbr -a la 'ls -A'
abbr -a ll 'ls -l'

if test (uname -s) = "Darwin"
    alias rm="trash"
end
