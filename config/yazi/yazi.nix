{ config, pkgs, ... }:
{
  programs.yazi.enable = true;
  home.file = {
    ".config/yazi/keymap.toml".source = ./config/keymap.toml;
    ".config/yazi/yazi.toml".source = ./config/yazi.toml;
  };
}
