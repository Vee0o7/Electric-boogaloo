{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.bigBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules;
      [
        bigBoogalooHardware
        common
        homeManagerBig
      ]
      ++ [inputs.home-manager.nixosModules.home-manager];
  };
}
