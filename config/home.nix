{ config, osConfig, pkgs, nixvim, lib, ... }:

{
  imports = [
    ./yazi
    ./zsh
    ./spotify
    ./helix
    nixvim.homeManagerModules.nixvim
    (./../hostHardware + "/${osConfig.networking.hostName}/home.nix")
  ];

  stylix.autoEnable = true;
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
    atlauncher

    ### cli ###
    tree
    nix-prefetch-git
    devenv
    ansifilter
    ripgrep
    imagemagick
    fd
    sd
    rsync
    tealdeer
    zsh-powerlevel10k
    direnv
    fzf

    ### random ###
    cowsay
    figlet
    fortune


    ### disk ###
    ntfs3g
    gparted
    nautilus

    ### misc ###
    obsidian
    cava
    vesktop
    whatsie
    libreoffice
    nsxiv
    xclip
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
  stylix.targets = {
    firefox.colorTheme.enable = true;
    firefox.profileNames = [ "viv" ];
    librewolf.colorTheme.enable = true;
    librewolf.profileNames = [ "viv" ];
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
      pull.rebase = true;
    };
    aliases = {
      co = "checkout";
      ci = "commit";
      ca = "commit --amend";
      squash = ''!git reset --soft $(git log --branches=$(git branch) --not --remotes --no-color --pretty=format:%H | ${lib.getExe pkgs.ansifilter} | tail -n 1) && git commit --amend -a'';
    };
  };
  systemd.user.startServices = "sd-switch";
}
