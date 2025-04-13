{pkgs, config, ...}:

let 
  background = ./floating-islands-rose.png;
  # bg-url = "https://w.wallhaven.cc/full/3l/wallhaven-3l66qd.png";
  # background = pkgs.fetchurl {
  #   url = bg-url;
  #   sha256 = "sha256-2wfvfzXDNEVc/3kBHe+r9JmorTmsNQCXvbhXNGKam7E=";
  # };
in
{
  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
    autoEnable = true;

    override = {
      base01 = config.stylix.generated.palette.base00;
    };
    image = background;

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 28;
    };
    polarity = "dark";
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
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
    };
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
