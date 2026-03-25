{inputs, self, ...}:
{
  flake.homeModules.viv = { pkgs, lib, ... }:
  {
    imports = with self.homeModules; [
      stylix
      hyprland
      noctalia
      zsh
      nvf
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
        protonup-ng
        wine
        atlauncher
        flatpak
        archipelago

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
        wl-clipboard
        android-tools
        legendary-gl

### random ###
        cowsay
        figlet
        fortune

### disk ###
        ntfs3g
        nautilus

### misc ###
        obsidian
        cava
        vesktop
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

    programs.git = {
      enable = true;
      signing.format = null;
      settings = {
      user.name = "Vee0o7";
      user.email = "114813444+Vee0o7@users.noreply.github.com";
        init.defaultBranch = "main";
        pull.rebase = true;
        alias = {
          co = "checkout";
          ci = "commit";
          ca = "commit --amend";
          squash = ''!git reset --soft $(git log --branches=$(git branch) --not --remotes --no-color --pretty=format:%H | ${lib.getExe pkgs.ansifilter} | tail -n 1) && git commit --amend -a'';
        };
      };
    };
    gtk.gtk4.theme = null;
    systemd.user.startServices = "sd-switch";
  };
}
