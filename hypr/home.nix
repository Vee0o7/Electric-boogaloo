{ pkgs, lib, config, inputs, extraInputs, ... }:
{
  imports = [
    ./waybar
    ./hypridle
    ./rofi
  ];
  home.packages = with pkgs; [
    hyprshot
    rofi-wayland
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
    xwayland.enable = true;
    package = null;
    portalPackage = null;
    plugins = [
      inputs.hyprspace.packages.${pkgs.system}.Hyprspace
    ];
    settings = lib.mkForce (import ./hyprland.nix {inherit extraInputs;});
  };
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
