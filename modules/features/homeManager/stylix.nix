{self, inputs, ...}:
{
  flake.homeModules.stylix = {...}:
  {
        stylix.autoEnable = true;
        stylix.targets = {
          firefox.colorTheme.enable = true;
          firefox.profileNames = [ "viv" ];
          librewolf.colorTheme.enable = true;
          librewolf.profileNames = [ "viv" ];
        };
  };
}
