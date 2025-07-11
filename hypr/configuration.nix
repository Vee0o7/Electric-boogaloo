{ pkgs, lib, config, inputs, ... }:
let
  inherit (lib) getExe;
in
{
  programs.light.brightnessKeys.enable = true;
  programs.uwsm = {
    enable = true;
    # waylandCompositors.hyprland = {
    #   prettyName = "Hyprland";
    #   comment = "Hyprland compositor managed by UWSM";
    #   binPath = "${getExe inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}";
    # };
  };
  services.greetd = {
    enable = true;
    vt = 2; # This prevents kernel logs from mangling greetd
    settings = {
      default_session = {
        command = "${getExe pkgs.greetd.tuigreet} --time --cmd uwsm start default";
        user = "greeter";
      };
      initial_session = {
        command = "uwsm start default";
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
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
  #   config.common.default = "*";
  # };

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
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
}
