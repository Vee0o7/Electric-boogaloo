{config, ...}:
{
  home.file = {
    ".config/rofi/menu.rasi".source = ./menu.rasi;
    ".config/rofi/powermenu.sh".source = ./powermenu.sh;
    ".config/rofi/powermenu.rasi".source = ./powermenu.rasi;
    ".config/rofi/fonts.rasi".source = ./fonts.rasi;
    ".config/rofi/config.rasi".source = ./config.rasi;
    ".config/rofi/colours.rasi".text = ''
* {
    background:     #${config.stylix.generated.palette.base00};
    background-alt: #${config.stylix.generated.palette.base00};
    foreground:     #${config.stylix.generated.palette.base05};
    selected:       #${config.stylix.generated.palette.base06};
    active:         #${config.stylix.generated.palette.base05};
    urgent:         #${config.stylix.generated.palette.base05};
}
    '';
  };
}
