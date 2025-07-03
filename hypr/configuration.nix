{ pkgs, lib, config, inputs, ... }:
let
  inherit (lib) getExe;
in
{
  programs.light.brightnessKeys.enable = true;
  services.greetd = {
    enable = true;
    vt = 2; # This prevents kernel logs from mangling greetd
    settings = {
      default_session = {
        command = "${getExe pkgs.greetd.tuigreet} --time --cmd hyprland";
        user = "greeter";
      };
      initial_session = {
        command = "hyprland";
        user = "viv";
      };
    };
  };
  # systemd.services.greetd.serviceConfig = {
  #   Type = "idle";
  #   StandardInput = "tty";
  #   StandardOutput = "tty";
  #   StandardError = "journal"; # Without this errors will spam on screen
  #   # Without these bootlogs will spam on screen
  #   TTYReset = true;
  #   TTYVHangup = true;
  #   TTYVTDisallocate = true;
  # };
  boot.plymouth.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  # Launches hyprland, redirecting output to systemd journal
  # environment.systemPackages = [
  #   (pkgs.writeShellApplication {
  #     name = "launch-hyprland";
  #     text = ''
  #       systemctl --user stop graphical-session.target
  #       uwsm start hyprland-uwsm.desktop
  #     '';
  #   })
  # ];

  programs.hyprland = {
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
}
