#!/bin/bash

set -e
err_exit() {
  echo "$@" > /dev/stderr
  exit 1
}

ensure_set() {
  local var="$1"
  if [ -z "${!var}" ]; then
    err_exit "${var} is not set. ${!var}"
  fi
}

ensure_vars() {
  ensure_set WIFI_NAME
  ensure_set WIFI_PASS
  ensure_set GH_TOKEN
}

clone_config() {
  if [ ! -d "$config_location" ]; then
    git clone "https://$GH_TOKEN@github.com/zwhitchcox/config.nix" "$config_location"
  fi
}

config_location=$HOME/config/nix
ensure_vars
bash "$(dirname "${BASH_SOURCE[0]}")/connect.sh" "$WIFI_NAME" "$WIFI_PASS"
clone_config

echo to continue installation
echo "cd $config_location
sudo bash installation/install.sh"

