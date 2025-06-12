{ config, osConfig, pkgs, nixvim, lib, ... }:

{
  imports = [
    ./yazi/yazi.nix
    nixvim.homeManagerModules.nixvim
    ./stylix/home-stylix.nix
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
    thefuck
  ];

  xsession.enable = true; # fixes session issues with logout and login
  home.sessionPath = [
    "$HOME/.dotfiles/bin"
  ];
  home.sessionVariables = {
    CHARGE_SHUTDOWN = 0;
  };

  xdg.configFile = {
    "autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=vesktop --start-minimized
        Name=Stylix: enable User Themes extension for GNOME Shell
      '';
  };

  programs.firefox = {
    enable = true;
    profiles.viv.extensions.force = true;
  };
  programs.librewolf = {
    enable = true;
    profiles.viv.extensions.force = true;
  };

  services.spotifyd = {
    enable = true;
    settings = {
      volume_normalisation = true;
      bitrate = 320;
      device = "shared";
      device_name = "spotifyd";
      # use_mpris = true; # Don't know what this does...
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

  ### Terminal stuff ###

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd"] ;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = true;
      mouse-hide-while-typing = true;
    };
  };
  # programs.starship = {
  #   enable = true;
  #   settings = {
  #     format = "$username$directory$git_branch$nix_shell$line_break$character";
  #     username.show_always = true;
  #   };
  #
  # };
  programs.nixvim = import ./neovim/nixvim.nix {inherit pkgs;};
  home.file = {
  };

  programs.zsh =
  {
    enable = true;
    shellAliases  = {
      ".." = "cd ..";
      "la" = "ls -a";
      "y" = "yazi";
      "cdd" = "cd $HOME/Documents";
      "spotifyrtp" = "pactl load-module module-rtp-send source=spotify.monitor";
    };
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["direnv" "fzf" "git" "thefuck" "git-auto-fetch" "copybuffer" "history"];
    };
    initContent = let after = lib.mkOrder 1600 "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"; before = lib.mkOrder 400 (''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme'');
      in lib.mkMerge [before after];
  };

  # programs.thefuck.enable = true;
  programs.dircolors = {
    enable = true;
    settings = {
      OTHER_WRITABLE = "30;42";
    };
  };
  services.xsettingsd = {
    enable = true;
  };

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
