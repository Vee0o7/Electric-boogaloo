{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.smolBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules;
      [
        smolBoogalooHardware
        common
        homeManagerSmol
        powerSave
      ]
      ++ [inputs.home-manager.nixosModules.home-manager ./variables.nix];
  };
}
