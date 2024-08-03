#!/usr/bin/env fish

if test (uname) != Darwin
	exit
end

if ! type -q brew
	exit
end

set BREW_PREFIX (brew --prefix)

for bindir in $BREW_PREFIX/opt/*/libexec/gnubin
    if string match -q '*/libtool/*' $bindir
        continue
    end
    fish_add_path -pmP $bindir
end

for mandir in $BREW_PREFIX/opt/*/libexec/gnuman $BREW_PREFIX/opt/*/share/man/man1
    set -gx MANPATH "$mandir:$MANPATH"
end
