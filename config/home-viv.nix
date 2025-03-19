{ config, pkgs, ... }:

{
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
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    ".config/ghostty".source = ./ghostty;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs.bash = {
    enable = true;
    shellAliases  = {
      ".." = "cd ..";
    };
  };

  programs.git = {
    enable = true;
    userName = "Vee0o7";
    userEmail = "vee314159@gmail.com";
  };

  programs.home-manager.enable = true;
}
