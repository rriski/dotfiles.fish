function asdf-prune -d "remove asdf versions that aren't in use"
    set -l tool

    for line in (asdf list)
        # Negative lookahead, match lines not starting with space
        if string match -q -r '^(?! ).*[^*]' "$line"
            set tool $line
        # Match lines not containing '*' (other installed versions)
        else if string match -q -r '^ [^*]' "$line"
            set old_version (echo "$line" | tr -d ' ')
            if test -n "$tool" -a -n "$old_version"
                echo "Running asdf uninstall $tool $old_version"
                asdf uninstall $tool $old_version
            end
        end
    end

    echo "All non-current versions have been removed."
end
