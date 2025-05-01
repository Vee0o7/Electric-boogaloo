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
      toggle-message-tray = [];
      minimize = [];
      screenshot = ["<Super>s"];
      show-screenshot-ui = ["<Shift><Super>s"];
      screenshot-window = ["<Alt>s"];
      close = ["<Super>q"];
      screensave = ["<Super>Escape"];
    };
in

{
  home.packages = with pkgs; [
    xclip
    xsel
  ];
  dconf.settings = {

    "org/gnome/shell/keybindings" = keybinds;
    "org/gnome/desktop/wm/keybindings" = keybinds;
    "org/gnome/mutter/wayland/keybindings".restore-shortcuts = [];

    "org/gnome/desktop/peripherals/touchpad".natural-scroll = false;

    "org/gnome/settings-daemon/plugins/media-keys"= {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
      www = ["<Super>f"];
      home = [];
    };
    "org/gnome/shell/extensions/forge/keybindings"= {
      prefs-tiling-toggle = [];
      window-focus-down = ["<Super>j"];
      window-focus-left = ["<Super>h"];
      window-focus-right = ["<Super>l"];
      window-focus-up = ["<Super>k"];
      window-swap-up = ["<Super><Shift>k"];
      window-swap-down = ["<Super><Shift>j"];
      window-swap-left = ["<Super><Shift>h"];
      window-swap-right = ["<Super><Shift>l"];
      window-move-up = [];
      window-move-down = [];
      window-move-left = [];
      window-move-right = [];
      con-stacked-layout-toggle = [];
    };

    # custom bindings #
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>w";
      command = "ghostty";
      name = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "ghostty -e yazi";
      name = "Yazi";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>m";
      command = "floorp --new-window https://open.spotify.com";
      name = "spotify";
    };
  };
}
