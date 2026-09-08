{
  self,
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosModules.homeManagerBig = {
    home-manager,
    specialArgs,
    ...
  }: {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hm-bak";
    home-manager.users.viv = {
      imports = [self.homeModules.viv self.homeModules.bigVariables];
    };
  };
}
