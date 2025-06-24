{ pkgs, lib, config, inputs, ... }:
{
  
  programs.hyprlock = {
    enable = true;
    settings = import ./hyprlock.nix;
  };
  home.packages = with pkgs; [
    hyprshot
  ];
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
}
