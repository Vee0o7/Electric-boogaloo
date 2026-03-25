{self, inputs, ...}:
{
  flake.homeModules.noctalia = {lib, ...}: {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia-shell = {
      enable = true;
      settings = lib.mkForce
        (builtins.fromJSON
         (builtins.readFile ./noctalia.json)).settings;
    };
  };
}
