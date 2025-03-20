{ config, pkgs, ... }:

{
  imports = [
    ./yazi/yazi.nix
  ];
  home.username = "viv";
  home.homeDirectory = "/home/viv";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    discord
    steam
    lutris
    cockatrice
    fastfetch
    tree
    ghostty
    nix-prefetch-git
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.nixvim = import ./neovim/nixvim.nix {inherit pkgs;};
  home.file = {
    ".config/ghostty".source = ./ghostty;
  };

  programs.bash = {
    enable = true;
    shellAliases  = {
      ".." = "cd ..";
      "y" = "yazi";
    };
  };

  programs.git = {
    enable = true;
    userName = "Vee0o7";
    userEmail = "vee314159@gmail.com";
  };

  programs.home-manager.enable = true;
}
