if status is-interactive
	if command -qs zoxide
		zoxide init fish | source
	end
end
