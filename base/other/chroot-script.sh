#!/bin/bash

# set settings related to locale
sed -i -e 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen 
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# set the time zone
ln -sf /usr/share/zoneinfo/MST /etc/localtime 
hwclock --systohc

# set hostname
echo -n "Enter hostname: "
read -r HOSTNAME
echo "${HOSTNAME}" >/etc/hostname

# configure hosts file
cat <<EOF >>/etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    ${HOSTNAME}
EOF

# set root user password
passwd

# install and configure grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# enable NetworkManager systemd service
systemctl enable NetworkManager

# add personal user
useradd -m -G wheel -s /usr/bin/zsh ray

#set password for user
passwd ray

#edit sudoers file
EDITOR=vim visudo

# yay install packages
yay -Syu grimblast-git swww ags cava hyprland swappy firefox swaylock neovim neofetch brightnessctl gvfs pipewire-pulse networkmanager sddm

