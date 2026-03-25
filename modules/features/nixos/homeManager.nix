{self, inputs, ...}:
{
  flake.nixosModules.homeManager = {home-manager, ...}:
  {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.viv = self.homeModules.viv;
  };
}
