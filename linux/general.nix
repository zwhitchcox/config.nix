
{ config, system, lib, pkgs, inputs, ... }:
{
  imports =
    [

      ./wm/gnome.nix
      ./sound
      ./fs.nix
    ];
  config = {
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
      };

      gc.automatic = true;
      gc.dates = "weekly";
      gc.options = "--delete-older-than 14d";

      optimise.automatic = true;
      # nixPath = pkgs;
    };
    programs.command-not-found.enable = false;
    services.dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
    environment.systemPackages = with pkgs; [
      vim
      git
      firefox
    ];

    systemd.services.upower.enable = true;


    programs.wshowkeys.enable = true;
    programs.fish.enable = true;

    # Earlyoom prevents systems from locking up when they run out of memory
    services.earlyoom.enable = true;
    # fstrim periodically discards flash storage blocks that aren't used by the file system
    services.fstrim.enable = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.utf8";

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "x1";


    # my additions
    fonts.fonts = [ pkgs.nerdfonts ];

    # List services that you want to enable:
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    services.accounts-daemon.enable = true;

    security.sudo.enable = true;

    services.udev.extraRules = ''
      # set scheduler for NVMe
      ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="kyber"
      # set scheduler for SSD and eMMC
      ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="kyber"
      # set scheduler for rotating disks
      ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
    '';
    services.timesyncd.enable = false;
    services.chrony = {
      enable = true;
      extraConfig = ''
        # Allow the system clock to be stepped in the first three updates
        # if its offset is larger than 1 second
        makestep 1.0 3
        # Enable kernel synchronization of the real-time clock (RTC).
        rtcsync
        bindcmdaddress 127.0.0.0
        bindcmdaddress ::1
        cmdport 0
      '';
      initstepslew = { enabled = false; };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    # users.users.zwhitchcox = {
    #   isNormalUser = true;
    #   description = "Zane Hitchcox";
    #   extraGroups = [ "networkmanager" "wheel" ];
    #   shell = pkgs.fish;
    #   packages = with pkgs; [
    #     firefox
    #     neovim
    #     polybar
    #   ];
    # };
    # users.mutableUsers = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    boot.kernelPackages = pkgs.linuxPackages_5_19;


    system.stateVersion = "22.05"; # Did you read the comment?
  };
}
