{self, inputs, ...}:
{
  flake.homeModules.nvf = {...}:
  {
    imports = [ inputs.nvf.homeManagerModules.default ];
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          vimAlias = true;
          searchCase = "smart";
          undoFile.enable = true;
          autopairs.nvim-autopairs.enable = true;
          treesitter.enable = true;
          telescope.enable = true;
          statusline.lualine.enable = true;
          options = {
            shiftwidth = 2;
            tabstop = 2;
            autoindent = true;
          };
          autocomplete.blink-cmp.enable = true;
          lsp.enable = true;
          languages = {
            nix.enable = true;
          };
        };
      };
    };
  };
}
