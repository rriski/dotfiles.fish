#!/usr/bin/env fish

# budimanjojo/tmux.fish
set -x fish_tmux_config "$HOME/.config/tmux/tmux.conf"
set -U fish_tmux_autostart true
set -U fish_tmux_autostart_once true
set -U fish_tmux_unicode true
set -U fish_tmux_default_session_name main
set -U fish_tmux_fixterm_with_256color "xterm-256color"
