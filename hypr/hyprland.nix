{extraInputs}:
let
    movetoworkspace = {n}: "exec, hyprctl dispatch movetoworkspace ${n}";
    toworkspace = {n}: "exec, hyprctl dispatch workspace ${n} && hyprctl dispatch overview:close";
in
{
###################
### MY PROGRAMS ###
###################
"$terminal" = "ghostty";
"$web" = "librewolf";
"$fileManager" = "yazi";
"$menu" = "rofi -show drun";
"$powermenu" = "zsh ~/.config/rofi/powermenu.sh";
"$screenshot" = "hyprshot -m region -m active --clipboard-only";
"$hyprlock" = "uwsm app -- hyprlock";

###################
### KEYBINDINGS ###
###################
"$mainMod" = "SUPER"; 

bind = [
"$mainMod shift, S, exec, $screenshot"
"$mainMod, C, exec, $themes"
"$mainMod, return, exec, $terminal"
"$mainMod, W, exec, $web"
"$mainMod, Q, killactive,"
"$mainMod, M, togglespecialworkspace"
"$mainMod, F, fullscreen"
"$mainMod, E, exec, $fileManager"
# "$mainMod shift, F, togglefloating,"
"$mainMod, space, exec, $menu"
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
"mainMod shift, mouse:272, movewindow"
# "mainMod shift shift, mouse:272, resizewindow"
];

bindel = [
",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
];

bindr = [
    "$mainMod, $mainMod_L, overview:toggle"
];


#################
### AUTOSTART ###
#################



exec-once = [
(if extraInputs.autologin then "" else "hyprlock")
"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
"dbus-update-activation-environment --systemd --all"
"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
"systemctl start --user hyprpaper.service"
"uwsm app -- waybar"
"[workspace special silent] ghostty --command=spotify_player"
"[workspace 1] ghostty --initial-command='sleep 2 && fastfetch && exec zsh'"
# "hyprpm enable Hyprspace"
];

#####################
### LOOK AND FEEL ###
#####################
plugin = {
    overview = {
        affectStrut = true;
        panelHeight = 150;
        gapsOut = 10;
        hideTopLayers = true;
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
"specialWorkspace, 1, 6, default, slidefadevert -50%"
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
    disable_hyprland_logo = false;
    vfr = true;
};


#############
### INPUT ###
#############

input = {
    kb_layout = extraInputs.kb;
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
windowrulev2 = [
"suppressevent maximize, class:.*"
"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
];
}
