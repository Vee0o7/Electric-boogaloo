{ config, osConfig, pkgs, nixvim, lib, ... }:

{
  imports = [
    ./yazi
    ./zsh
    nixvim.homeManagerModules.nixvim
    ./stylix/home-stylix.nix
    (./../hostHardware + "/${osConfig.networking.hostName}/home.nix")
  ];
  home.username = "viv";
  home.homeDirectory = "/home/viv";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    steam

    lutris
    cockatrice
    tree
    nix-prefetch-git
    protonup
    # vesktop
    wine
    devenv
    ansifilter
    expect
    flatpak
    ntfs3g
    gparted
    obsidian
    cava
    vesktop
    fzf
    whatsie
    libreoffice
    ripgrep
    imagemagick
    fd
    eclipses.eclipse-java
    trx
    rsync
    tealdeer
    nsxiv
    zsh-powerlevel10k
    direnv
  ];

  xsession.enable = true; # fixes session issues with logout and login
  home.sessionPath = [
    "$HOME/.dotfiles/bin"
  ];

  # xdg.configFile = {
  #   "autostart/vesktop.desktop".text = ''
  #       [Desktop Entry]
  #       Type=Application
  #       Exec=vesktop --start-minimized
  #       Name=Stylix: enable User Themes extension for GNOME Shell
  #     '';
  # };
  
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    profiles.viv = {
      extensions.force = true;
    };
  };

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        volume_normalisation = true;
        bitrate = 320;
        # device = "shared";
        # device_name = "spotifyd";
        initial_volume = 70;
      };
    };
  };

  programs.spotify-player = {
    enable = true;
    keymaps = [
      # {command = "None"; key_sequence = "q";}
      {command.VolumeChange.offset = 5; key_sequence  = "=";}
    ];
    settings = {
      enable_streaming = false;
      client_id_command = { command = "cat"; args = ["${config.home.homeDirectory}/.spotifyid"];};
      default_device = ''Spotifyd@${osConfig.networking.hostName}'';
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        disableLinewrap = true;
      };
      modules= [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "locale"
        "break"
        "colors"
      ];
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = true;
      mouse-hide-while-typing = true;
    };
  };

  programs.nixvim = import ./neovim/nixvim.nix {inherit pkgs;};


  programs.git = {
    enable = true;
    userName = "Vee0o7";
    userEmail = "114813444+Vee0o7@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
    aliases = {
      co = "checkout";
      ci = "commit";
      ca = "commit --amend";
    };
  };
  systemd.user.startServices = "sd-switch";
}
