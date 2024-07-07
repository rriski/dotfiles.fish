#!/usr/bin/env fish

# Install flatpak apps
sudo apt install -y flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

set apps \
    com.github.qarmin.czkawka \
    com.bitwarden.desktop \
    net.lutris.Lutris \
    com.discordapp.Discord \

for app in $apps
    echo $app
    flatpak install -y flathub $app
end
