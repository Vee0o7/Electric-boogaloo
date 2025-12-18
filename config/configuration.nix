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

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
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

      # My own additions
      xorg.xcbutil
      xorg.xcbutilrenderutil
      xcb-util-cursor
      xcb-imdkit
      xcbuild
      xcb-proto
      xcbutilxrm
      xcbuildHook
      xorg.xcbutilwm
      xorg.xcbutilkeysyms
      xorg.xcbutilimage
      xorg.xcbproto
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
      
      # Without these it silently fails
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

      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed
      
      # Verified games requirements
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libidn
      tbb
      
      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      xorg.libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      expat
      # Needed for electron
      libdrm
      mesa
      libxkbcommon
      # Needed to run, via virtualenv + pip, matplotlib & tikzplotlib
      stdenv.cc.cc.lib # to provide libstdc++.so.6
      pkgs.gcc-unwrapped.lib # maybe only the first one needed

      # needed to run appimages
      fuse # needed for musescore 4.2.1 appimage
      e2fsprogs # needed for musescore 4.2.1 appimage
      fribidi # needed for xournalpp (nightly 08/11/2024)
      librsvg # needed for xournalpp (nightly)
      ibus # needed for xournalpp (nightly)
    ];
};
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

  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr ];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  services.flatpak.enable = true;

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
