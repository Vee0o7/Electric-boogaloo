{pkgs, ...}:

{
  stylix = {
    autoEnable = true;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/harmonic16-dark.yaml";
    image = ../../background.jpg;
    polarity = "dark";
  };
}
