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
        };
      };
    };
  };
}
