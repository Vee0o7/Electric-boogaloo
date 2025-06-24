{
# exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

###################
### MY PROGRAMS ###
###################
"$terminal" = "ghostty";
"$web" = "librewolf";
"$fileManager" = "yazi";
"$menu" = "rofi -show drun";
"$powermenu" = "zsh ~/.config/rofi/powermenu.sh";
"$screenshot" = "hyprshot -m region -m active --clipboard-only";
"$hyprlock" = "hyprlock";
"$killpanel" = "killall waybar";
"$startpanel" = "waybar";

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
"$mainMod, M, exit"
"$mainMod, F, fullscreen"
"$mainMod, E, exec, $fileManager"
"alt, F, togglefloating,"
"$mainMod, space, exec, $menu"
"$mainMod, escape, exec, $powermenu"
"alt, S, togglesplit, "
"$mainMod, H, movefocus, l"
"$mainMod, J, movefocus, d"
"$mainMod, K, movefocus, u"
"$mainMod, L, movefocus, r"
"$mainMod, 1, workspace, 1"
"$mainMod, 2, workspace, 2"
"$mainMod, 3, workspace, 3"
"$mainMod, 4, workspace, 4"
"$mainMod, 5, workspace, 5"
"$mainMod shift, 1, movetoworkspace, 1"
"$mainMod shift, 2, movetoworkspace, 2"
"$mainMod shift, 3, movetoworkspace, 3"
"$mainMod shift, 4, movetoworkspace, 4"
"$mainMod shift, 5, movetoworkspace, 5"
];

bindm = [
"alt, mouse:272, movewindow"
"alt shift, mouse:272, resizewindow"
];

bindel = [
",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
];

# bindr = $mainMod, $mainMod_L, overview:toggle


#################
### AUTOSTART ###
#################



exec-once = [
"waybar"
# "hyprpm enable Hyprspace"
];

#####################
### LOOK AND FEEL ###
#####################
# plugin = {
#     hyprexpo = {
#         columns = 3;
#         gap_size = 5;
#         workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
#
#         enable_gesture = true;
#         gesture_fingers = 3;
#         gesture_distance = 300;
#         gesture_positive = true;
#     };
# };

general = {
    gaps_in = 1;
    gaps_out = 0;
    border_size = 3;
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
        enabled = "true, blur";
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
};


#############
### INPUT ###
#############

input = {
    kb_layout = "gb";
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
