#!/bin/bash


git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -is
cd .. && rm -rf yay
# yay install packages
yay -Syu grimblast-git swww ags cava hyprland swappy firefox swaylock neovim neofetch brightnessctl gvfs pipewire-pulse networkmanager sddm


git clone https://github.com/evilTachyMeter/archBasic.git
cd archBase/config
cp -r font/* ~/.local/share/fonts
cp -r .config/* ~/.config
cp -r .scripts ~/ # Optional
cd -
