{
mainbar = {
  layer = "bottom";
  modules-left = [
    "custom/power"
    "battery"
    "backlight"
    "pulseaudio"
  ];
  modules-center = [
    "clock"
  ];
  modules-right = [
    "cava"
    "tray"
    "hyprland/workspaces"
  ];
  pulseaudio = {
    tooltip = false;
    scroll-step = 5;
    format = "{icon}  {volume}%";
    format-muted = "muted";
    on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
    format-icons = {
      default = [
        ""
        ""
        ""
      ];
    };
  };
  cava = {
    framerate = 120;
    autosens = 1;
    sensitivity = 5;
    bars = 12;
    lower_cutoff_freq = 50;
    higher_cutoff_freq = 10000;
    method = "pulse";
    source = "shared.monitor";
    stereo = false;
    reverse = false;
    bar_delimiter = 0;
    monstercat = true;
    waves = true;
    noise_reduction = 0.85;
    input_delay = 0;
    format-icons = [
      "▁"
      "▂"
      "▃"
      "▄"
      "▅"
      "▆"
      "▇"
      "█"
    ];
  };
  "custom/keybinds" = {
    format = "{icon} KB";
    format-icons = [
      "󰘳"
    ];
    on-click = "bash ~/Documents/themes/keybinds/keybinds.sh";
  };
  backlight = {
    device = "intel_backlight";
    format = "{icon}  {percent}%";
    format-icons = [
      ""
      ""
    ];
  };
  battery = {
    bat = "BAT0";
    interval = 60;
    states = {
      warning = 30;
      critical = 15;
    };
    format = "{icon}  {capacity}%";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
    ];
    max-length = 25;
  };
  tray = {
    icon-size = 18;
    spacing = 10;
  };
  privacy = {
    icon-spacing = 10;
    icon-size = 18;
    transition-duration = 250;
    tooltip = false;
    modules = [
      {
        type = "screenshare";
        tooltip = true;
        tooltip-icon-size = 24;
      }
      {
        type = "audio-out";
        tooltip = true;
        tooltip-icon-size = 24;
      }
      {
        type = "audio-in";
        tooltip = true;
        tooltip-icon-size = 24;
      }
    ];
  };
  "custom/power" = {
    format = "⏻ ";
    tooltip = false;
    on-click = "bash ~/.config/rofi/powermenu.sh";
    on-click-right = "killall rofi";
  };
  clock = {
    format = "{:%R}";
    tooltip = false;
  };
  "hyprland/workspaces" = {
    format = "{icon}";
    tooltip = false;
    format-icons = {
      "1" = "";
      "2" = "";
      "3" = "";
      "4" = "";
      "5" = "";
      urgent = "";
      active = "";
      default = "";
    };
  };
  };
}
