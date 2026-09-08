{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.umbriel = {
    imports = [inputs.umbriel.nixosModules.default];
    programs.umbriel.enable = true;
  };
  flake.homeModules.umbriel = {config, ...}: {
    imports = [self.homeModules.umbrielKeybinds inputs.umbriel.homeModules.default];
    programs.umbriel = {
      enable = true;
      settings = {
        general.autostart = ["noctalia"];
        layout = {
          mode = "scrolling";
          gap = 4;
        };
        input = {
          keyboard.layout = config.var.keyboardLayout;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
          };
          keybinds = {
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
      };
    };
  };
}
