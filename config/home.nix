{ config, osConfig, pkgs, nixvim, lib, ... }:

{
  imports = [
    ./yazi
    ./zsh
    ./spotify
    nixvim.homeManagerModules.nixvim
    ./stylix/home.nix
    (./../hostHardware + "/${osConfig.networking.hostName}/home.nix")
  ];
  home.username = "viv";
  home.homeDirectory = "/home/viv";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nerd-fonts.fira-code

    ### gaming ###
    steam
    lutris
    cockatrice
    protonup
    wine

    ### cli ###
    tree
    nix-prefetch-git
    devenv
    ansifilter
    ripgrep
    imagemagick
    fd
    rsync
    tealdeer
    zsh-powerlevel10k
    direnv
    fzf

    ### disk ###
    ntfs3g
    gparted

    ### misc ###
    obsidian
    cava
    vesktop
    whatsie
    libreoffice
    nsxiv
  ];

  home.sessionPath = [
    "$HOME/.dotfiles/bin"
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    profiles.viv = {
      extensions.force = true;
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
