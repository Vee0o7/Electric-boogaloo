
{ pkgs, lib, config, ... }: 

{
  nixpkgs.overlays = [
    (final: prev: {
      gnome-shell = prev.gnome-shell.overrideAttrs (oldAttrs: {
          postPatch = oldAttrs.postPatch + ''

            sed -i 's/#define ACCENT_COLOR_BLUE   \"#......\"/#define ACCENT_COLOR_BLUE   \"#${config.lib.stylix.colors.base0D}\"/' src/st/st-theme-context.c
          '';                                                                               #newcol set to base0D
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.gnused ];
      });
    })
  ];
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    # cheese
    geary
    adwaita-icon-theme
    # nixos-background-info This can't be excluded since it's defined locally. So even if we removed all GNOME backgrounds it seems we have to keep the NixOS one.
    gnome-backgrounds
    gnome-bluetooth
    # gnome-color-manager
    # gnome-control-center
    gnome-shell-extensions
    gnome-themes-extra
    pkgs.gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    pkgs.gnome-user-docs
    pkgs.orca
    # pkgs.glib # for gsettings program
    pkgs.gnome-menus
    # pkgs.gtk3.out # for gtk-launch program
    # pkgs.xdg-user-dirs # Update user dirs as described in https://freedesktop.org/wiki/Software/xdg-user-dirs/
    baobab
    epiphany
    pkgs.gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    pkgs.gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    # gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    seahorse
    # evince
    # pkgs.loupe
    # nautilus
    pkgs.gnome-connections
    simple-scan
    pkgs.snapshot
    totem
    yelp
    # file-roller
  ];

}
