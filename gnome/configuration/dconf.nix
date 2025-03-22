{...}:
{
  dconf.settings = {

    "org/gnome/desktop/wm/preferences" = {
      theme = "Nordic-darker";
      # click focus or sloppy enables hover focus
      focus-mode = "click";
      raise-on-click = false;
      auto-raise = false;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/background" = {
      # color-shading-type = "solid";
      # picture-options = "zoom";
      # picture-uri = "${./../../v4-background-dark.jpg}";
      # picture-uri-dark = "${./../../v4-background-dark.jpg}";
      # primary-color = "#000000000000";
      # secondary-color = "#000000000000";
    };
  };
}
