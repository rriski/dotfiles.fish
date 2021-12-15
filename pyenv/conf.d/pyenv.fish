if status is-login
	pyenv init --path | source
end

if status is-interactive
	pyenv init - | source
    pyenv virtualenv-init - | source
end
