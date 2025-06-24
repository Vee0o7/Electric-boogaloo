{ pkgs, lib, config, inputs, ... }:
{
  
  home.packages = with pkgs; [
    hyprshot
    waybar
    rofi-wayland
  ];
  services.hyprpaper.enable = true;
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
    settings = lib.mkForce (import ./hyprland.nix);
  };
  home.file = {
    ".config/waybar" = {
      source = ./waybar;
      onChange = "pkill waybar && waybar";
    };
    ".config/rofi".source = ./rofi;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
