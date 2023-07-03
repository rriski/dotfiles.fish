if status is-login
	if command -qs poetry
		poetry completions fish > $__fish_config_dir/completions/poetry.fish
	end
end

if status is-interactive
	if command -qs poetry
		poetry completions fish > $__fish_config_dir/completions/poetry.fish
	end
end
