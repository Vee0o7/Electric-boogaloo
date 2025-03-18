{ pkgs, lib, ... }:

{
  vim.theme.enable = true;
  vim.theme.transparent = true;
  vim.theme.name = "nord";

  vim.languages.nix.enable = true;
}
