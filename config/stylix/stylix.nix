{pkgs, config, ...}:

let 
  theme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
in
{
  fonts.fontconfig.enable = true;

  stylix = {
    autoEnable = true;
    enable = true;
    base16Scheme = theme;
    override = {
      base01 = "232136";
    };
    image = ./backgrounds/floatingIslands.png;

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 28;
    };
    polarity = "dark";
    opacity = {
    };
    fonts = {
      serif = {
        package = pkgs.fira-sans;
        name = "Fira Sans 12";
      };
      sansSerif = config.stylix.fonts.serif;
      monospace = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };
    };
    targets.floorp.profileNames = [ "viv" ];
    targets.floorp.firefoxGnomeTheme.enable = true;
  };
}

#################### potential themes ####################
# "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
# "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
# "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";
# "${pkgs.base16-schemes}/share/themes/atelier-lakeside.yaml";
# "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
# "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
# "${pkgs.base16-schemes}/share/themes/atelier-heath.yaml";
# "${pkgs.base16-schemes}/share/themes/darkviolet.yaml";
# "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
# "${pkgs.base16-schemes}/share/themes/pandora.yaml";
# "${pkgs.base16-schemes}/share/themes/purpledream.yaml";
# "${pkgs.base16-schemes}/share/themes/tarot.yaml";
# "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";
