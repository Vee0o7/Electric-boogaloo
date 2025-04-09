
{ pkgs, lib, config, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./../config/configuration.nix
    ];
  nixpkgs.overlays = [
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (oldAttrs: {
        # GNOME dynamic triple buffering (huge performance improvement)
        # See https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441
        src = final.fetchFromGitLab {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-47";
          hash = "sha256-6n5HSbocU8QDwuhBvhRuvkUE4NflUiUKE0QQ5DJEzwI=";
        };

        preConfigure =
          let
            gvdb = final.fetchFromGitLab {
              domain = "gitlab.gnome.org";
              owner = "GNOME";
              repo = "gvdb";
              rev = "2b42fc75f09dbe1cd1057580b5782b08f2dcb400";
              hash = "sha256-CIdEwRbtxWCwgTb5HYHrixXi+G+qeE1APRaUeka3NWk=";
            };
          in
          ''
            cp -a "${gvdb}" ./subprojects/gvdb
          '';
      });
    })
  ];
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.xserver.enableTearFree = true;

  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    cheese
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
    gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    seahorse
    evince
    pkgs.loupe
    # nautilus
    pkgs.gnome-connections
    simple-scan
    pkgs.snapshot
    totem
    yelp
    file-roller
  ];

}
