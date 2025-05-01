{ pkgs, lib, config, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, W, exec, ghostty"
        "$mod, F, exec, floorp"
        "$mod, Q, killactive"
        ", $mod, plugin:overview:toggle"
      ] ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i+1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ] ) 9)
        );
    };
    plugins = [
      pkgs.hyprlandPlugins.hyprspace
    ];
  };
}
