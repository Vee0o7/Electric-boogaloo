{self, inputs, ...}:
{
  flake.homeModules.hyprland = {pkgs, lib, config, ...}:
  {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
      package = null;
      portalPackage = null;
      plugins = [
# inputs.hyprspace.packages.${pkgs.system}.Hyprspace
# inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      ];
    };

    wayland.windowManager.hyprland.settings =
      let
      movetoworkspace = {n}: "exec, hyprctl dispatch movetoworkspace ${n}";
    toworkspace = {n}: ''exec, hyprctl dispatch workspace ${n} & bash -c "hyprctl monitors | grep -Po 'workspace.+special:\K.*(?=\))' | xargs -r hyprctl dispatch togglespecialworkspace "'';
    scratchpad = {name}: "hyprctl dispatch togglespecialworkspace ${name}";
    keyboardLayout = config.var.keyboardLayout;
    inherit (lib) getExe;
    in
    {

      xwayland = {
        force_zero_scaling = true;
      };
###################
### MY PROGRAMS ###
###################
      "$terminal" = "ghostty";
      "$web" = "librewolf";
      "$fileManager" = "yazi";
      "$launcher" = "noctalia-shell ipc call launcher toggle";
      "$powermenu" = "noctalia-shell ipc call sessionMenu toggle";
      "$screenshot" = "${getExe pkgs.grimblast} copy";
      "$hyprlock" = "uwsm app -- hyprlock";

###################
### KEYBINDINGS ###
###################
      "$mainMod" = "SUPER"; 

      bind = [
        "$mainMod shift, S, exec, $screenshot area"
          "$mainMod, S, exec, $screenshot"
          "$mainMod, return, exec, $terminal"
          "$mainMod, W, exec, $web"
          "$mainMod, Q, killactive,"
          "$mainMod, N, exec, $notes"
          "$mainMod, M, exec, ${scratchpad {name="music";}}"
          "$mainMod, V, exec, ${scratchpad {name="volume";}}"
          "$mainMod, F, fullscreen"
          "$mainMod, E, exec, $fileManager"
# "$mainMod shift, F, togglefloating,"
          "$mainMod, space, exec, $launcher"
          "$mainMod, escape, exec, $powermenu"
# "$mainMod shift, S, togglesplit, "
          "$mainMod, H, movefocus, l"
          "$mainMod, J, movefocus, d"
          "$mainMod, K, movefocus, u"
          "$mainMod, L, movefocus, r"
          "$mainMod, 1, ${toworkspace {n="1";}}"
          "$mainMod, 2, ${toworkspace {n="2";}}"
          "$mainMod, 3, ${toworkspace {n="3";}}"
          "$mainMod, 4, ${toworkspace {n="4";}}"
          "$mainMod, 5, ${toworkspace {n="5";}}"
          "$mainMod shift, 1, ${movetoworkspace {n="1";}}"
          "$mainMod shift, 2, ${movetoworkspace {n="2";}}"
          "$mainMod shift, 3, ${movetoworkspace {n="3";}}"
          "$mainMod shift, 4, ${movetoworkspace {n="4";}}"
          "$mainMod shift, 5, ${movetoworkspace {n="5";}}"
          ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
          "alt shift, mouse:272, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} s 5%+"
          ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} s 5%-"
      ];

      bindr = [
# "$mainMod, $mainMod_L, overview:toggle"
        # "$mainMod, $mainMod_L, hyprexpo:expo, toggle"
      ];


#################
### AUTOSTART ###
#################



      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "noctalia-shell"
# "[workspace special:music silent] ghostty --command=spotify_player"
          "[workspace special:volume silent] pavucontrol"
# "[workspace 1] ghostty --initial-command='sleep 1.5 && fastfetch && exec zsh'"
      ];

#####################
### LOOK AND FEEL ###
#####################
      plugin = {
        overview = {
# affectStrut = false;
# panelHeight = 150;
# gapsOut = 10;
# hideTopLayers = false;
        };
      };

      general = {
        gaps_in = 1;
        gaps_out = 0;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 0.95;
        inactive_opacity = 0.925;
        shadow = {
          enabled = "false, glow";
          range = 25;
          render_power = 1000;
        };
        blur = {
          enabled = "false, blur";
          size = 1;
          passes = 1;

          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = "true, animations";

        bezier = [
          "winIn, 0.1, 1.0, 0.1, 1.0"
            "winOut, 0.1, 1.0, 0.1, 1.0"
            "smoothOut, 0.5, 0, 0.99, 0.99"
            "layerOut,0.23,1,0.32,1"
        ];

        animation = [
          "windowsIn, 1, 7, winIn, slide"
            "windowsOut, 1, 3, smoothOut, slide"
            "windowsMove, 1, 7, winIn, slide"
            "workspacesIn, 1, 8, winIn, slide"
            "workspacesOut, 1, 8, winOut, slide"
            "specialWorkspace, 1, 6, default, slidefadevert -90%"
            "layersIn, 1, 10, winIn, slide"
            "layersOut, 1, 3, layerOut, popin 50%"
        ];

      };

      dwindle = {
        pseudotile = true ;
        preserve_split = true ;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        # disable_hyprland_logo = true;
        # vfr = (if extraInputs.autologin then true else false);
      };


#############
### INPUT ###
#############

      input = {
        kb_layout = keyboardLayout;
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0.7;
        repeat_rate = 50;
        repeat_delay = 200;
        touchpad = {
          natural_scroll = false;
        };
      };

##############################
### WINDOWS AND WORKSPACES ###
##############################
      windowrule = [
        "suppress_event maximize, match:class .*"
# "no_focus on, match:class:^$, match:title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "opacity 0.7 override, match:class org.pulseaudio.pavucontrol"
        "opacity 1 override, match:class librewolf"
      ];
    };
  };

  flake.nixosModules.hyprland = { pkgs, lib, ... }:
  let
    inherit (lib) getExe;
  in
  {
    programs.uwsm.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${getExe pkgs.tuigreet} --time";
          user = "greeter";
        };
        initial_session = {
          command = "uwsm start default";
          user = "viv";
        };
      };
    };
    boot.plymouth.enable = true;
# xdg.portal = {
#   enable = true;
#   extraPortals = [inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
#   config.common.default = "*";
# };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };
  };
}
