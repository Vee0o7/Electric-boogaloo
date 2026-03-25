{self, inputs, ...}:
{
  flake.nixosModules.homeManagerSmol = {home-manager, specialArgs, ...}:
  {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.viv = {
          imports = [ self.homeModules.viv ./variables.nix ];
        };
  };
}
