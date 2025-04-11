
{ pkgs, lib, config, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./../config/configuration.nix
    ];
  nixpkgs.overlays = [
    (final: prev: {
      # gnome-shell = let
      #   originalPackage = prev.gnome-shell;
      #
      #   # We use `overrideAttrs` instead of defining a new `mkDerivation` to keep
      #   # the original package's `output`, `passthru`, and so on.
      #   overwrittenGnome-shell = originalPackage.overrideAttrs (old: {
      #     name = "gnome-shell-overridden";
      #
      #     # Using `buildCommand` replaces the original packages build phases.
      #     buildCommand = ''
      #       set -euo pipefail
      #
      #       ${
      #         # Copy original files, for each split-output (`out`, `dev` etc.).
      #         # E.g. `${package.dev}` to `$dev`, and so on. If none, just "out".
      #         # Symlink all files from the original package to here (`cp -rs`),
      #         # to save disk space.
      #         # We could alternatiively also copy (`cp -a --no-preserve=mode`).
      #         lib.concatStringsSep "\n"
      #           (map
      #             (outputName:
      #               ''
      #                 echo "Copying output ${outputName}"
      #                 set -x
      #                 cp -rs --no-preserve=mode "${originalPackage.${outputName}}" "''$${outputName}"
      #                 set +x
      #               ''
      #             )
      #             (old.outputs or ["out"])
      #           )
      #       }
      #
      #       # Example change:
      #       # Change `usage:` to `USAGE:` in a shell script.
      #       # Make the file to be not a symlink by full copying using `install` first.
      #       # This also makes it writable (files in the nix store have `chmod -w`).
      #       install -v "${originalPackage}"/src/st/st-theme.c {$out}/src/st/st-theme.c
      #       sed -i -e 's/#define ACCENT_COLOR_BLUE   \"#3584e4\"/#define ACCENT_COLOR_BLUE   \"#ab8853\"/' "$out"/src/st/st-theme-context.c
      #     '';
      #
      #   }); in overwrittenGnome-shell;
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
