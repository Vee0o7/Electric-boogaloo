{pkgs, ...}:

{
  stylix = {
    autoEnable = true;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = ../../background.jpg;
    polarity = "dark";
    opacity = {
      terminal = 0.95;
      applications = 0.95;
    };
  };
}
