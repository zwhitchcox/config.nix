{ config, pkgs, lib, ... } @inputs:
let
  inherit (lib) optional;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;

  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });

in
{
  xdg.configFile."scripts".source = mkOutOfStoreSymlink "${nixConfigDirectory}/scripts";
  programs.fish.shellInit = ''
    # command-not-found replacement
    # see https://github.com/bennofs/nix-index#usage-as-a-command-not-found-replacement
    # source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh

    set scriptdir $HOME/.config/scripts
    if [ -d $scriptdir ];
      for p in $scriptdir/* ;
        if not contains $p $fish_user_paths && not string match -q "*.md" $p;
          set -g fish_user_paths $fish_user_paths $p
        end
      end
    end
  '';
}
