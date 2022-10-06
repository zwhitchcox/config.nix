{ config, lib, pkgs, ... }:

{
  # environment.pathsToLink = [ "/libexec" ];
  # environment.systemPackages = with pkgs; [
  #     vulkan-tools
  #     vulkan-loader
  #     vulkan-headers
  #     glxinfo
  #     libva-utils
  #     linuxPackages_zen.v4l2loopback
  #     libv4l
  #     xawtv
  #     ueberzug
  #     dfeet
  # ];
  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  #   extraPackages32  = [ pkgs.driversi686Linux.vaapiIntel ];
  #   extraPackages = [
  #     pkgs.amdvlk
  #     pkgs.intel-media-driver
  #     pkgs.vaapiIntel
  #     pkgs.vaapiVdpau
  #     pkgs.libvdpau-va-gl
  #     pkgs.libva
  #   ];
  # };

  #services.autorandr.enable = true;
  # Enable the X11 windowing system.
  services = {
    # GUI interface
    xserver = {
      enable = true;
      autorun = true;
      layout = "us";
      # Enable touchpad support.
      libinput.enable = true;
      desktopManager = {
        xterm.enable = false;
      };

      # videoDrivers = [ "intel" ];

      displayManager = {
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
          # sysstat
        ];
      };
    };
  };
}

