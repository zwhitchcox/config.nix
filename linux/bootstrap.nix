{ config, lib, pkgs, ... }:

rec {
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    trusted-users = [ "@admin" ];

    auto-optimise-store = true;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") [ "x86_64-darwin" "aarch64-darwin" ];
  };


  # Shells -----------------------------------------------------------------------------------------

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    fish
    zsh
  ];

#   # Make Fish the default shell
#   programs.fish.enable = true;
#   programs.fish.useBabelfish = true;
#   # Needed to address bug where $PATH is not properly set for fish:
#   # https://github.com/LnL7/nix-darwin/issues/122
#   programs.fish.shellInit = ''
#     set scriptdir $HOME/.config/scripts
#     if [ -d $scriptdir ];
#       for p in $scriptdir/* ;
#         if not contains $p $fish_user_paths
#           set -g fish_user_paths $fish_user_paths $p
#         end
#       end
#     end
#   '';
  # environment.variables.SHELL = "/run/current-system/sw/bin/zsh";

  # Install and setup ZSH to work with nix as well
  programs.zsh.enable = true;
}
