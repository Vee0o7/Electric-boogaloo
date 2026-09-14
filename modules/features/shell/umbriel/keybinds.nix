{
  self,
  inputs,
  ...
}: {
  flake.homeModules.umbrielKeybinds = {
    programs.umbriel.settings.keybinds = {
      "Mod+Return" = "spawn:ghostty";
      "Mod+Q" = "window-close";
      "Mod+Space" = "spawn:noctalia msg panel-toggle launcher";
      "Mod" = "overview-toggle";
      "Mod+W" = "spawn:librewolf";
      "XF86AudioRaiseVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      "XF86AudioLowerVolume" = "spawn:wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      "XF86AudioMute" = {
        action = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        allow_when_locked = true;
      };
      "XF86MonBrightnessDown" = {
        action = "spawn:noctalia msg brightness-down 10";
        allow_when_locked = true;
      };
      "XF86MonBrightnessUp" = {
        action = "spawn:noctalia msg brightness-up 10";
        allow_when_locked = true;
      };
      "Mod+M" = "window-toggle-maximize-to-edges";
      "Mod+Escape" = "spawn:noctalia msg panel-open session";
      "Mod+H" = "window-focus-left";
      "Mod+L" = "window-focus-right";
      "Mod+K" = "window-focus-up";
      "Mod+J" = "window-focus-down";
      "Mod+WheelUp" = {
        action = "window-focus-right";
        cooldown_ms = 150;
      };
      "Mod+WheelDown" = {
        action = "window-focus-left";
        cooldown_ms = 150;
      };
    };
  };
}
