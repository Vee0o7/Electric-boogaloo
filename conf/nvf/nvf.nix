{ pkgs, lib, ... }:

{
  vim.theme.enable = true;
  vim.theme.transparent = true;
  vim.theme.name = "nord";
  vim.useSystemClipboard = true;

  vim.languages.nix.enable = true;
}
