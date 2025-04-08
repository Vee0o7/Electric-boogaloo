{pkgs, config, ...}:

let 
  theme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
in
{
  fonts.fontconfig.enable = true;

  stylix = {
    autoEnable = true;
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-lakeside.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-heath.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/darkviolet.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/pandora.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/purpledream.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tarot.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/uwunicorn.yaml";
    image = ../../such-sweet-poetry_rosepine-nt.png;
    base16Scheme = theme;

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 28;
    };
    polarity = "dark";
    opacity = {
      terminal = 0.95;
      applications = 0.95;
    };
    fonts = {
      serif = {
        package = pkgs.fira-sans;
        name = "Fira Sans";
      };
      sansSerif = {
        package = pkgs.fira-sans;
        name = "Fira Sans";
      };
      monospace = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };
    };
    targets.floorp.profileNames = [ "viv" ];
    targets.floorp.firefoxGnomeTheme.enable = true;
  };
}
