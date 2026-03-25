{self, inputs, ...}:
{
  flake.nixosConfigurations.smolBoogaloo = inputs.nixpkgs.lib.nixosSystem {
    modules = with inputs.self.nixosModules; [
      smolBoogalooHardware
      hyprland
      stylix
      common
      homeManager
    ] ++ [ inputs.home-manager.nixosModules.home-manager ];

  };
}
