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
      close = ["<Super>q"];
    };
in
{
  imports = [./custom-keybinds.nix ./gnome-extensions.nix];

  gtk =
  let 
    nightfox-icons = import ./nightfox-icons.nix { inherit pkgs; };
  in
  {
    enable = true;
    iconTheme.package = nightfox-icons;
    iconTheme.name = "Duskfox";
    theme.package = pkgs.nordic;
    theme.name = "Nordic-darker";
  };

  dconf.settings = {

    "org/gnome/desktop/wm/preferences" = {
      theme = "Nordic-darker";
      focus-mode = "sloppy";
      raise-on-click = false;
      auto-raise = false;
    };
    "org/gnome/shell/keybindings" = keybinds;
    "org/gnome/desktop/wm/keybindings" = keybinds;

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

    "org/gnome/desktop/peripherals/touchpad".natural-scroll = false;
  };
}
