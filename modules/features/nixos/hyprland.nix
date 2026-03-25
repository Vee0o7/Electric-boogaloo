{self, inputs, ...}:
{
  flake.nixosModules.hyprland = { pkgs, lib, ... }:
  let
    inherit (lib) getExe;
  in
  {
    programs.uwsm.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${getExe pkgs.tuigreet} --time";
          user = "greeter";
        };
        initial_session = {
          command = "uwsm start default";
          user = "viv";
        };
      };
    };
    boot.plymouth.enable = true;
# xdg.portal = {
#   enable = true;
#   extraPortals = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
#   config.common.default = "*";
# };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };
  };
}
