{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    # GUI interface
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      # Enable touchpad support.
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          tappingDragLock = true;
        };
      };
      synaptics.tapButtons = true;

      # Enable the Gnome desktop manager
      displayManager.gdm.enable    = true;
      desktopManager.gnome.enable = true;
    };
  };
}

