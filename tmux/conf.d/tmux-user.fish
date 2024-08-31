if status is-interactive
    if test -n "$TMUX" \
        -o "$TERM_PROGRAM" = "vscode" \
        -o "$TERM_PROGRAM" = "zed"
        set -g fish_vi_force_cursor 1
    end
end
