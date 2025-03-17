{pkgs, lib, ...}:

{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys"= {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      www = ["<Super>f"];
      home = ["<Super>e"];
    };
    "org/gnome/shell/extensions/forge/keybindings".prefs-tiling-toggle = [];
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>w";
      command = "kgx";
      name = "Terminal";
    };
  };
}
