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
      "Mod+XF86AudioMute" = "spawn:wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86MonBrightnessDown" = ''{ action = "spawn:noctalia msg brightness-down 10", allow_when_locked = true }'';
    };
  };
}
