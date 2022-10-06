{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;
  systemd.services.upower.enable = true;

  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      # Enable touchpad support.
      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
        };
      };
      serverLayoutSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"     "0"
      '';
      displayManager.defaultSession = "none+xmonad";
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
      # does not work, setting it manually on start up
      # xkbOptions = "ctrl:nocaps";
      # Enable the Gnome desktop manager
      # displayManager.gdm.enable    = true;
      # desktopManager.gnome.enable = true;
    };
  };
}
