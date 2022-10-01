#!/usr/bin/env bash

# source nix
[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# install packages
nix-env -iA \
  nixpkgs.home-manager
