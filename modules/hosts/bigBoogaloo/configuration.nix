{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.bigBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules;
      [
        bigBoogalooHardware
        noctalia
        stylix
        common
        homeManagerBig
        pipewire
      ]
      ++ [inputs.home-manager.nixosModules.home-manager];
  };
}
