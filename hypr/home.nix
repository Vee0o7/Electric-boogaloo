{ pkgs, lib, config, inputs, extraInputs, ... }:
{
  imports = [
    ./waybar
    ./hypridle
    ./rofi
    ./hyprlock.nix
    ./hyprland
  ];
  home.packages = with pkgs; [
    hyprshot
    rofi-wayland
    inputs.pyprland.packages.${pkgs.system}.pyprland
  ];
  services.hyprpaper = {
    enable = true;
    settings.ipc = "off";
  };
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
