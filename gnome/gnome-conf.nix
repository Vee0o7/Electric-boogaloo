{pkgs, lib, ...}: 

{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "dash-to-panel@home-sweet-gnome.github.com"
      ];
    };
    "org/gnome/shell/extensions/dash-to-panel" = {
      
    };
  };
}
