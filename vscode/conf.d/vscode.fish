#!/usr/bin/env fish

if type -q code
	if [ "$TERM_PROGRAM" = "vscode" ]
		. (code --locate-shell-integration-path fish)
  	end
end
