if status is-interactive
	if command -qs aws
		if type -q aws_completer
			complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
		end
	end
end
