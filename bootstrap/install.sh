#!/bin/bash

set -e
err_exit() {
  echo "$@" > /dev/stderr
  exit 1
}

ensure_set() {
  local var="$1"
  if [ -z "${!var}" ]; then
    echo "${var} is not set. ${!var}" > /dev/stderr
    usage
    exit 1
  fi
}

usage() {
  echo "bash ${BASH_SOURCE[0]} hostname [device]" 1>&2
}

while :; do
  case "$1" in
    --no-fs)
      nofs=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

HOSTNAME=$1
DEVICE=${2:-/dev/nvme0n1}

ensure_vars() {
  ensure_set HOSTNAME
}

ensure_device() {
  if [ ! -e $DEVICE ]; then
    err_exit "Could not find $DEVICE"
  fi
}

init_fs() {
  sudo bash installation/fs.sh  $DEVICE
}

generate_hw() {
  hw_location=system/hw/$HOSTNAME.nix
  if [ ! -f $hw_location ]; then
    nixos-generate-config --no-filesystems --show-hardware-config > $hw_location
  fi
systemconf=system/default.nix
  if grep -q $HOSTNAME $systemconf; then
    return 0;
  fi
  last_brace=$(grep -n '}' $systemconf | tail -n 1 | cut -d: -f 1)
  sed -i "${last_brace}d" $systemconf
  echo "  $HOSTNAME"' = nixosSystem {' >> $systemconf
  cat >> $systemconf  << EOF
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
EOF
  echo "      ./hw/$HOSTNAME.nix" >> $systemconf
  cat >> $systemconf  << EOF
      ./fs.nix
      ./conf.nix
    ];
  };
}
EOF
}

install_flake() {
  set -x
  sudo nixos-install --flake .#$HOSTNAME
}

pushd $HOME/nix-config
  ensure_vars
  ensure_device
  [ $nofs == true ] || init_fs
  generate_hw
  install_flake
popd

