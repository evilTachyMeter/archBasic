#!/bin/bash

# check if boot type is UEFI
ls /sys/firmware/efi/efivars || { echo "Boot Type Is Not UEFI!; "exit 1; }

# check if internet connection exists
ping -q -c 1 archlinux.org >/dev/null || { echo "No Internet Connection!; "exit 1; }

# update system clock
timedatectl set-ntp true

# read the block device name you want to install Arch on
clear
devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
BLOCK_DEVICE=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 
clear


# make a 550 MB EFI partition along with a Linux partition with fdisk
fdisk "${BLOCK_DEVICE}" <<EOF
g
n
1

+550M
t
1
n
2


w
EOF

# show the created new partitions
lsblk

# format EFI partition
mkfs.fat -F32 "${BLOCK_DEVICE}1"

# format Linux partition
mkfs.ext4 -m 1 "${BLOCK_DEVICE}2"

# mount the Linux partition
mount "${BLOCK_DEVICE}2" /mnt

# create boot directory
mkdir -p /mnt/boot

# mount the EFI partiton
mount "${BLOCK_DEVICE}1" /mnt/boot

# show the mounted partitions
lsblk

# install necessary packages
pacstrap -K /mnt base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware vim git networkmanager grub os-prober efibootmgr

# Generate an fstab config
genfstab -U /mnt >>/mnt/etc/fstab

# copy chroot-script.sh to /mnt
cp chroot-script.sh /mnt

# chroot into the new system and run the chroot-script.sh script
arch-chroot /mnt ./chroot-script.sh

# unmount partitions
umount /mnt/boot /mnt
