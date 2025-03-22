{pkgs, lib, ...}: 

# let
#   nordic-firefox = import ./nordic-firefox.nix {inherit pkgs;};
# in
  let 
    nightfox-icons = import ./nightfox-icons.nix { inherit pkgs; };
  in
{
# home.file = {
#   ".nordic-firefox".source = nordic-firefox;
# };
  gtk =
  {
    enable = true;
    iconTheme.package = nightfox-icons;
    iconTheme.name = "Duskfox";
  };
}
