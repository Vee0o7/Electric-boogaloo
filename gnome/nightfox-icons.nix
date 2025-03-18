{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "nightfox-icons";

  src = pkgs.fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Nightfox-GTK-Theme";
    sha256 = "1qmrbgr5a5p6b0jriwqvgiz517kzs88205949zjc52hh97rfhnjm";
    rev = "d9534b5275eb4bc588890c7bd8b30cf2b535c8e0";
  };

  installPhase = ''
    mkdir -p $out/share
    cp -R ./icons $out/share/
    '';
}
