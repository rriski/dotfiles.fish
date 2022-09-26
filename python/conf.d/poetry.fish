if status is-login
	if command -qs poetry
		poetry completions fish > ~/.config/fish/completions/poetry.fish
	end
end

if status is-interactive
	if command -qs poetry
		poetry completions fish > ~/.config/fish/completions/poetry.fish
	end
end
