# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./pipewire
    ./stylix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    curl
    home-manager
    htop
    pulseaudioFull
    pavucontrol
    libnotify
    iwd
    protonvpn-gui
    python3
  ];
  programs.npm.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  systemd.extraConfig = ''DefaultTimeoutStopSec=10s'';

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    wayland
    fontconfig
    xorg.libX11
    xorg.libSM
    libxkbcommon
    zlib
    zstd
    stdenv.cc.cc
    curl
    openssl
    attr
    libssh
    bzip2
    libxml2
    acl
    libsodium
    util-linux
    xz
    systemd
    xcb-util-cursor
    xcbuild
    xorg.xcbutilrenderutil
    
    # My own additions
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    xorg.libXext
    xorg.libX11
    xorg.libXfixes
    libGL
    libva
    pipewire
    xorg.libxcb
    xorg.libXdamage
    xorg.libxshmfence
    xorg.libXxf86vm
    libelf

    # Required
    glib
    gtk2

    # Inspired by steam
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
    networkmanager      
    vulkan-loader
    libgbm
    libdrm
    libxcrypt
    coreutils
    pciutils
    zenity
    # glibc_multi.bin # Seems to cause issue in ARM
    
    # # Without these it silently fails
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXi
    xorg.libSM
    xorg.libICE
    gnome2.GConf
    nspr
    nss
    cups
    libcap
    SDL2
    libusb1
    dbus-glib
    ffmpeg
    # Only libraries are needed from those two
    libudev0-shim
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Enable networking
  networking.networkmanager.enable = true;


  users.users.viv = {
    isNormalUser = true;
    description = "viv";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      inherit pkgs;
    };
  };

  nix.extraOptions = ''
      trusted-users = root viv
  '';
  security.sudo.wheelNeedsPassword = false;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  documentation.man.generateCaches = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    TERM="ghostty";
  };
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  # prioritise ram over swap
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  programs.gamemode.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  system.stateVersion = "24.11"; # Did you read the comment?

}
