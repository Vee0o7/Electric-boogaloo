{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./stylix/stylix.nix
    ./yazi/yazi.nix
  ];
  home.username = "viv";
  home.homeDirectory = "/home/viv";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = (with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    steam
    lutris
    cockatrice
    fastfetch
    tree
    nix-prefetch-git
    protonup
    vesktop
    wine
    devenv
    ansifilter
    expect
    flatpak
    ntfs3g
    gparted
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ]) ++ (with pkgs-unstable; [
  ]);
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  xdg.configFile = {
    "autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=vesktop --start-minimized
        Name=Stylix: enable User Themes extension for GNOME Shell
      '';
  };

  programs.floorp.enable = true;

  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = true;
      mouse-hide-while-typing = true;
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
      "y" = "yazi";
    };
    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
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

  programs.home-manager.enable = true;
}
