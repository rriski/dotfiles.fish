if status is-login
	if command -qs pyenv
		pyenv init --path | source
	end
end

if status is-interactive
	if command -qs pyenv
		pyenv init - | source
		pyenv virtualenv-init - | source
	end
end
