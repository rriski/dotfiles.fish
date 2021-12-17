local config = {}

function config.nvim_tmux()
    require("tmux").setup({
		-- overwrite default configuration
		-- here, e.g. to enable default bindings
		copy_sync = {
			-- enables copy sync and overwrites all register actions to
			-- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
			enable = true,
			redirect_to_clipboard = true,
			sync_clipboard = false,
		},
		navigation = {
			-- enables default keybindings (C-hjkl) for normal mode
			enable_default_keybindings = true,
		},
		resize = {
			-- enables default keybindings (A-hjkl) for normal mode
			enable_default_keybindings = true,
		}
	})
end

return config
