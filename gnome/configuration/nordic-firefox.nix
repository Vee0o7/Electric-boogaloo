{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "firefox-nordic";

  src = pkgs.fetchFromGitHub {
    owner = "EliverLara";
    repo = "firefox-nordic-theme";
    sha256 = "0pgxrjqqsabnhsq21cgnzdwyfwc4ah06qk0igzwwsf56f2sgs4yv";
    rev = "21b79cca716af87b8a2b9e420c0e1d3d08b67414";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./* $out
    '';
}


