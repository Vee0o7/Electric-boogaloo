{ config, pkgs, nixvim, ... }:

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
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  xsession.enable = true; # fixes seesion issues with logout and login
  home.sessionPath = [
    "$HOME/.dotfiles/bin"
    # "$HOME/.local/share/coursier/bin"
  ];

  xdg.configFile = {
    "autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=vesktop --start-minimized
        Name=Stylix: enable User Themes extension for GNOME Shell
      '';
  };

  programs.floorp = {
    enable = true;
    profiles.viv.extensions.force = true;
  };

  services.spotifyd = {
    enable = true;
    settings = {
      volume_normalisation = true;
      bitrate = 320;
    };
  };

  programs.spotify-player = {
    enable = true;
  };

  programs.fastfetch = {
    enable = true;
  };

  ### Terminal stuff ###

  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = true;
      mouse-hide-while-typing = true;
    };
  };
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$directory$git_branch$nix_shell$line_break$character";
      username.show_always = true;
    };

  };
  programs.direnv.enable = true;
  programs.nixvim = import ./neovim/nixvim.nix {inherit pkgs;};
  home.file = {
  };

  programs.bash = {
    enable = true;
    shellAliases  = {
      ".." = "cd ..";
      "la" = "ls -a";
      "y" = "yazi";
      "cdd" = "cd $HOME/Documents";
    };
    bashrcExtra = ''
      eval "$(direnv hook bash)"
      bind 'set completion-ignore-case on'
      fastfetch
    '';
  };
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
