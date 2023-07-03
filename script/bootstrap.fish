#!/usr/bin/env fish
#
# bootstrap installs things.

source ./script/utils.fish

curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
	and success 'fisher'
	or abort 'fisher'

setup_gitconfig
	and success 'gitconfig'
	or abort 'gitconfig'

install_dotfiles
	and success 'dotfiles'
	or abort 'dotfiles'

fisher update
	and success 'plugins'
	or abort 'plugins'

mkdir -p $__fish_config_dir/completions/
	and success 'completions'
	or abort 'completions'

for installer in */install.fish
	$installer
		and success $installer
		or abort $installer
end

if ! grep (command -v fish) /etc/shells
	command -v fish | sudo tee -a /etc/shells
		and success 'added fish to /etc/shells'
		or abort 'setup /etc/shells'
	echo
end

test (which fish) = $SHELL
	and success 'dotfiles installed/updated!'
	and exit 0


if command -qs chsh
	chsh -s (which fish)
		and success set (fish --version) as the default shell
		or abort 'set fish as default shell'
else if command -qs usermod
	usermod -s (which fish) $USER
		and success set (fish --version) as the default shell
		or abort 'set fish as default shell'
end

success 'dotfiles installed/updated!'
