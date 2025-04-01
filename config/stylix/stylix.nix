{pkgs, ...}:

{
  stylix = {
    autoEnable = true;
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-lakeside.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-heath.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/darkviolet.yaml";
    image = ../../background.jpg;
    polarity = "dark";
    opacity = {
      terminal = 0.95;
      applications = 0.95;
    };
    targets.floorp.profileNames = [ "viv" ];
    targets.floorp.firefoxGnomeTheme.enable = true;
  };
}
