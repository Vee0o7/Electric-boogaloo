{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "rose-pine-cursors";

  src = pkgs.fetchFromGitHub {
    owner = "harishnkr";
    repo = "Bibata-Original-Cursors";
    sha256 = "17p2a7azd1cvgnzkr9qfd0may9swzxpr3y3i3lirdj3wdchzmys3";
    rev = "bbfda3cfd9e50d04986c0083588254925d57fff1";
  };

  installPhase = ''
    mkdir -p $out/share/icons/
    cp -R ./* $out/share/icons/
    '';
}
