{ config, pkgs, ... }:

{
  imports = [
    ./stylix/stylix.nix
    ./yazi/yazi.nix
  ];
  home.username = "viv";
  home.homeDirectory = "/home/viv";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    steam
    lutris
    cockatrice
    fastfetch
    tree
    nix-prefetch-git
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.ghostty.enable = true;
  programs.nixvim = import ./neovim/nixvim.nix {inherit pkgs;};
  home.file = {
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
    userEmail = "114813444+Vee0o7@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      co = "checkout";
      ci = "commit";
      ca = "commit --amend";
    };
  };

  programs.home-manager.enable = true;
}
