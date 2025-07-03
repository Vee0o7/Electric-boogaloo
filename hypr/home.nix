{ pkgs, lib, config, inputs, extraInputs, ... }:
{
  imports = [
    ./waybar
    ./hypridle
  ];
  home.packages = with pkgs; [
    hyprshot
    rofi-wayland
    # nwg-panel
  ];
  services.hyprpaper = {
    enable = true;
    settings.ipc = "off";
  };
  programs.hyprlock = {
    enable = true;
    settings = import ./hyprlock.nix;
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
    ];
    settings = lib.mkForce (import ./hyprland.nix {inherit extraInputs;});
  };
  home.file = {
    ".config/rofi".source = ./rofi;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
