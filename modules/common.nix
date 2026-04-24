{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.common = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vim
      wget
      git
      curl
      htop
      pulseaudioFull
      pavucontrol
      libnotify
      iwd
      proton-vpn
      python3
      gparted
      networkmanagerapplet
      simplescreenrecorder
      obs-studio
    ];

    programs.npm.enable = true;
    virtualisation.virtualbox.host.enable = true;
    services.upower.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    systemd.settings.Manager = {
      # DefaultTimeoutStopSec = "10s";
    };

    # Enable networking
    networking.networkmanager = {
      enable = true;
    };

    users.users.viv = {
      isNormalUser = true;
      description = "viv";
      extraGroups = ["networkmanager" "wheel"];
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
      drivers = with pkgs; [epson-escpr];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
    services.flatpak.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://hyprland.cachix.org"
        "https://noctalia.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
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
    documentation.man.cache.enable = true;

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      TERM = "ghostty";
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
  };
}
