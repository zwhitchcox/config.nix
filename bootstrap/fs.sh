#!/bin/bash

set -ex
err_exit() {
  echo "$@" > /dev/stderr
  exit 1
}
[ -z "$1" ] && err_exit "must supply path to disk"
disk="$1"

get_part_base() {
  if [[ $1 == /dev/sd* ]]; then
    echo $1
  elif [[ $1 == /dev/nvme* ]]; then
    echo $1p
  else
    err_exit "unrecognized base $disk"
  fi
}

part_base="$(get_part_base "$disk")"

# create partition table
sudo parted "$disk" -- mklabel gpt
sudo parted "$disk" -- mkpart primary 512MB -8GB
sudo parted "$disk" -- mkpart primary linux-swap -8GB 100%
sudo parted "$disk" -- mkpart ESP fat32 1MB 512MB
sudo parted "$disk" -- set 3 esp on

# provision fs's
mkfs.ext4 -L nixos "$part_base"1
mkswap -L swap  "$part_base"2
mkfs.fat -F 32 -n boot "$part_base"3

# wait for labels to show up
sleep 1

# mount fs's
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot/efi
mount /dev/disk/by-label/boot /mnt/boot/efi

nixos-generate-config --root /mnt

echo "edit your config and then run nixos-install"
