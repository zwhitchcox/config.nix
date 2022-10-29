# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:
with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps= ["firefox.desktop" "org.gnome.Console.desktop"];
    };
  };
}
