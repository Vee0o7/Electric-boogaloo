{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.smolBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules;
      [
        smolBoogalooHardware
        # kde
        noctalia
        stylix
        common
        homeManagerSmol
        powerSave
        pipewire
      ]
      ++ [inputs.home-manager.nixosModules.home-manager ./variables.nix];
  };
}
