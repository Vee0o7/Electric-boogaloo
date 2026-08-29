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
            (builtins.readFile ./noctalia/config.toml));
      };
    };

    xdg.configFile = {
      "umbriel/config.toml".source = ./umbriel/config.toml;
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
