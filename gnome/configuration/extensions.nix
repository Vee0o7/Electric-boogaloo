{pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.forge
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.user-themes
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.color-picker
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
        "rounded-window-corners@fxgn"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "blur-my-shell@aunetx"
        "appindicatorsupport@rgcjonas.gmail.com"
        "color-picker@tuberry"
      ];
    };
    "org/gnome/shell/extensions/just-perfection".window-picker-icon = false;
    "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
      skip-libadwaita-app = false;
      global-rounded-corner-settings = ''{'padding': <{'left': uint32 0, 'right': 0, 'top': 1, 'bottom': 1}>, 'keepRoundedCorners': <{'maximized': false, 'fullscreen': false}>, 'borderRadius': <uint32 10>, 'smoothing': <0.0>, 'borderColor': <(0.5, 0.5, 0.5, 1.0)>, 'enabled': <true>}'';
      focused-shadow = ''{'verticalOffset': 4, 'horizontalOffset': 0, 'blurOffset': 0, 'spreadRadius': 0, 'opacity': 0}'';
      unfocused-shadow = ''{'verticalOffset': 4, 'horizontalOffset': 0, 'blurOffset': 0, 'spreadRadius': 0, 'opacity': 0}'';
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
        panel-positions = ''{"0":"TOP"}'';
        panel-sizes = ''{"0":32}'';
        trans-use-custom-opacity = true;
        trans-panel-opacity = 0.0;
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
      search-fuzzy = true;
    };
    "org/gnome/shell/extensions/forge" = {
      stacked-tiling-mode-enabled = false;
      tabbed-tiling-mode-enabled = false;
      focus-border-toggle = false;
      dnd-center-layout = "swap";
      window-gap-size =  lib.hm.gvariant.mkUint32 1;
      window-gap-hidden-on-single = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = false;
    };
    "org/gnome/shell/extensions/blur-my-shell/applications".blacklist = ["Gimp-2.10" "gimp" "floorp"];
    "org/gnome/shell/extensions/blur-my-shell/panel/applications" = {
      blur-on-overview = false;
      opacity = 244;
      enable-all = true;
      sigma = 0;
    };
  };
}
