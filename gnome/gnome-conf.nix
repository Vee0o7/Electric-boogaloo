{pkgs, lib, ...}: 

let 
  keybinds = 
    {
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      screenshot = ["<Super>s"];
      show-screenshot-ui = ["<Shift><Super>s"];
      screenshot-window = ["<Alt>s"];
    };
in
{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.forge
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
        "vertical-workspaces@G-dH.github.com"
        "forge@jmmaranan.com"
      ];
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
        panel-positions = ''{"0":"TOP"}'';
        panel-sizes = ''{"0":32}'';
        trans-use-custom-opacity = true;
        trans-panel-opacity = 0.1;
        trans-use-custom-gradient = true;
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
    "org/gnome/extensions/forge" = {
      stacked-tiling-mode-enabled = false;
      tabbed-tiling-mode-enabled = false;
      focus-border-toggle = false;
      dnd-center-layout = "swap";
      window-gap-size = 2;
      window-gap-hidden-on-single = true;
    };
    "org/gnome/desktop/wm/keybindings" = keybinds;
    "org/gnome/shell/keybindings" = keybinds;
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "${./../v4-background-dark.jpg}";
      picture-uri-dark = "${./../v4-background-dark.jpg}";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
  };
}
