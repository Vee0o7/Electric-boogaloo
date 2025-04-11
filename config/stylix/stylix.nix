{pkgs, config, ...}:

let 
  # background = ./backgrounds/floatingIslands.png;
  background = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/2y/wallhaven-2yp6gg.png";
    sha256 = "sha256-//uMITUU6Uv8iok5KgWNv3sC/0I1ElVCEraoI66w8Fg=";
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
        cat $HOME/.cache/wal/colors.json | awk 'NR != 2' > $out
      '';
  }));
  palette = (pywal16palette background).colors;
in
{
  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
    targets.gnome.enable = true;
    # accent colors are done separately with a custom gnome-shell (if using gnome)
    base16Scheme = {
      base00 = palette.color0;
      base01 = palette.color0;
      base02 = palette.color2;
      base03 = palette.color3;
      base04 = palette.color4;
      base05 = palette.color15;
      base06 = palette.color6;
      base07 = palette.color7;
      base08 = palette.color8;
      base09 = palette.color9;
      base0A = palette.color10;
      base0B = palette.color11;
      base0C = palette.color12;
      base0D = palette.color13;
      base0E = palette.color14;
      base0F = palette.color15;
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
        package = pkgs.fira-code-nerdfont;
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
