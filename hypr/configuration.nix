{ pkgs, lib, config, inputs, ... }:
let
  inherit (lib) getExe;
in
{
  boot.kernelParams = [ "console=tty1" ];
  services.greetd = {
    enable = true;
    vt = 2; # This prevents kernel logs from mangling greetd
    settings = {
      default_session = {
        command = "${getExe pkgs.greetd.tuigreet} --time --cmd hyprland";
        user = "greeter";
      };
      initial_session = {
        command = "${getExe pkgs.greetd.tuigreet} --time --cmd hyprland";
        user = "viv";
      };
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
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
