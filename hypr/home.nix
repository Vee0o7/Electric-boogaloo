{ pkgs, lib, config, inputs, ... }:
{
  
  programs.hyprlock.enable;
  programs.hyprshot.enable;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
    ];
    home.file = {
      ".config/hypr".source = ./hypr;
      ".config/waybar" = {
        source = ./waybar;
	onChange = "pkill waybar && waybar";
      };
      ".config/rofi".source = ./rofi;
    };
  };
}
