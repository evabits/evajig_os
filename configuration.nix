{ lib, pkgs, ... }@args:

let
  serial = import ./helpers/serial.nix;
  users = import ./home args;

  interface = "wlp170s0";
in
{
  # initial version, not the current version. NEVER EVER EDIT ME!
  system.stateVersion = "24.05";

  imports = [
    <home-manager/nixos>
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "sdhci_pci" ];
    # modules enabled in kernel-space
    kernelModules = [ "iwlwifi" ];
    # extra modules from nixpkg
    extraModulePackages = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      #timeout = 0;
    };


    plymouth = {
      enable = true;
      theme = "evajig";
      themePackages = with pkgs; [
        (import pkgs/plymouth-evajig.nix { })
      ];
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    kernelPackages = pkgs.linuxPackages_latest;
  };


  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking = {
    # Use DHCP on all interfaces
    # useDHCP = true;

    # my hostname depends on the machine
    hostName = "evajig-" + (serial interface);

    # just use NetworkManager, it's easy!
    networkmanager.enable = true;
  };

  # We're in Amsterdam, mien jung
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "segger-jlink-qt4-796s"
    ];
    segger-jlink.acceptLicense = true;
  };

  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      windowManager.openbox.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.options = "eurosign:e,caps:escape";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    openssh.enable = true;

    getty.autologinUser = "evajig";
  };

  services.udev.extraRules = builtins.readFile files/udev.rules;

  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    pciutils
    usbutils
  ];

  hardware.firmware = with pkgs; [
    linux-firmware
  ];

  programs.zsh.enable = true;

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  users.users = lib.mergeAttrsList (map (u: { "${u.name}" = u.user; }) users);
  home-manager.users = lib.mergeAttrsList (map (u: { "${u.name}" = ({ ... }: u.home-manager); }) users);
}

