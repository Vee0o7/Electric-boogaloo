{pkgs, config, ...}:

let 
  # background = ./backgrounds/floatingIslands.png;
  bg-url = "https://w.wallhaven.cc/full/3l/wallhaven-3l66qd.png";
  background = pkgs.fetchurl {
    url = bg-url;
    sha256 = "sha256-2wfvfzXDNEVc/3kBHe+r9JmorTmsNQCXvbhXNGKam7E=";
  };
  fromYAML = yaml:
    builtins.fromJSON (builtins.readFile (pkgs.stdenv.mkDerivation {
      name = "fromYAML";
      phases = [ "buildPhase" ];
      buildPhase = "echo '${yaml}' | ${pkgs.yaml2json}/bin/yaml2json > $out";
  }));
  pywal16palette = image:
    builtins.fromJSON (builtins.readFile (pkgs.stdenv.mkDerivation {
      name = "bg2colors";
      nativeBuildInputs = [
        pkgs.imagemagick
        pkgs.colorz
      ];
      phases = [ "preBuild" "buildPhase" ];
      preBuild = ''
        export HOME=$(mktemp -d)
        export CONF_DIR=$(mktemp -d)
        export CACHE_DIR=$(mktemp -d)
      '';
      buildPhase = ''
        ${pkgs.pywal16}/bin/wal -i ${background} --backend colorz
        cat $HOME/.cache/wal/colors.json | sed 's/.*wallpaper.*/ /' > $out
      '';
  }));
  palette = (pywal16palette background).colors;
in
{
  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
    autoEnable = true;

    # base16Scheme = {
    #   name = "pywal colorz theme: " + bg-url;
    #   base00 = palette.color0;
    #   base01 = palette.color0;
    #   base02 = palette.color2;
    #   base03 = palette.color3;
    #   base04 = palette.color4;
    #   base05 = palette.color15;
    #   base06 = palette.color6;
    #   base07 = palette.color7;
    #   base08 = palette.color8;
    #   base09 = palette.color9;
    #   base0A = palette.color10;
    #   base0B = palette.color11;
    #   base0C = palette.color12;
    #   base0D = palette.color13;
    #   base0E = palette.color14;
    #   base0F = palette.color15;
    # };
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
