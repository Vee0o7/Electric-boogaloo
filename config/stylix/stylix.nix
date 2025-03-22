{pkgs, ...}:

{
  stylix = {
    autoEnable = true;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = ../../background.jpg;
    polarity = "dark";
    targets = {
      ghostty.enable = true;
    };
  };
}
