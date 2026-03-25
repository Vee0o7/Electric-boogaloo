{self, inputs, ...}:
{
  flake.nixosConfigurations.bigBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules; [
      bigBoogalooHardware
      hyprland
      stylix
      common
      homeManager
    ] ++ [ inputs.home-manager.nixosModules.home-manager ];

  };
}
