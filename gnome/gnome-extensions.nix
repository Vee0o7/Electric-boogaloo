{pkgs, lib, ...}:
{
    home.packages = with pkgs; [
      gnomeExtensions.dash-to-panel
      gnomeExtensions.vertical-workspaces
      gnomeExtensions.forge
      gnomeExtensions.rounded-corners
    ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [];
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
        "vertical-workspaces@G-dH.github.com"
        "forge@jmmaranan.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
        panel-positions = ''{"0":"TOP"}'';
        panel-sizes = ''{"0":32}'';
        trans-use-custom-opacity = false;
        trans-panel-opacity = 0.1;
        trans-use-custom-gradient = false;
        trans-gradient-top-opacity = 0.25;
        trans-gradient-bottom-opacity = 0.0;
        scroll-panel-action = "NOTHING";
        scroll-icon-action = "NOTHING";
        panel-element-positions = ''{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":false,"position":"stackedTL"},{"element":"systemMenu","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":false,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"centerMonitor"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
'';
    };
    "org/gnome/shell/extensions/vertical-workspaces" = {
      hot-corner-action = 0;
      wst-position-adjust = 0;
      overview-bg-blur-sigma = 10;
      panel-overview-style = 0;
      show-ws-preview-bg = false;
    };
    "org/gnome/shell/extensions/forge" = {
      stacked-tiling-mode-enabled = false;
      tabbed-tiling-mode-enabled = false;
      focus-border-toggle = false;
      dnd-center-layout = "swap";
      window-gap-size =  lib.hm.gvariant.mkUint32 0;
      window-gap-hidden-on-single = true;
    };
  };
}
