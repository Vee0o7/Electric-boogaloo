{self, inputs, ...}:
{
  flake.homeModules.stylix = {...}:
  {
        stylix.autoEnable = true;
        stylix.targets = {
          firefox.colorTheme.enable = true;
          firefox.profileNames = [ "viv" ];
          librewolf.colorTheme.enable = true;
          librewolf.profileNames = [ "viv" ];
        };
  };

  flake.nixosModules.stylix = {pkgs, config, ...}:
  let background = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/md/wallhaven-md6dqk.jpg";
    hash = "sha256-9CK50o765thC6f8w3HzNLEUGYgZmu+1U+j8mgTR9qLw=";
  };
  in
  {
    imports = [ inputs.stylix.nixosModules.stylix ];

    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      autoEnable = true;

# override = {
#   base01 = config.stylix.generated.palette.base00;
# };
      image = background;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

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
