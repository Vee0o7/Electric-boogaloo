{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      transparent = true;
      name = "nord";
    };
    useSystemClipboard = true;
    autocomplete.enableSharedCmpSources = true;
    statusline.lualine.enable = true;
    telescope.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
    };
  };
}
