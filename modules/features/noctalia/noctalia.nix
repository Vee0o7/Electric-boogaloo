{
  self,
  inputs,
  ...
}: {
  flake.homeModules.noctalia = {lib, ...}: {
    imports = [inputs.noctalia.homeModules.default];
    programs = {
      noctalia = {
        enable = true;
        settings =
          lib.mkForce
          (builtins.fromTOML
            (builtins.readFile ./noctalia.toml));
      };
    };
  };

  flake.nixosModules.noctalia = {
    pkgs,
    lib,
    ...
  }: {
    programs.umbriel.enable = true;
  };
}
