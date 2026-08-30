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
    # imports = [./greeter/config.nix];
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia-greeter = {
      enable = true;
    };
    programs.umbriel.enable = true;
  };
}
