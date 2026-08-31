{
  self,
  inputs,
  ...
}: {
  flake.homeModules.template = {...}: {
  };

  flake.nixosModules.template = {
    pkgs,
    config,
    ...
  }: let
    test = "";
  in {
  };
}
