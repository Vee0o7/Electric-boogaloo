{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.smolBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules;
      [
        smolBoogalooHardware
        hyprland
        # kde
        stylix
        common
        homeManagerSmol
        powerSave
      ]
      ++ [inputs.home-manager.nixosModules.home-manager ./variables.nix];
  };
}
