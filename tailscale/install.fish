#!/usr/bin/env fish

switch (uname)
case Darwin
	set -l tailscale_path "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
	if test -f $tailscale_path
		alias -s tailscale $tailscale_path
	end
case Linux
	if ! command -qs tailscale
		curl -fsSL https://tailscale.com/install.sh | sh
	end
end


