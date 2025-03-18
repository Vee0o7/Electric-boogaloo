{pkgs, lib, ...}: 

{
  gtk =
  let 
    nightfox-icons = import ./nightfox-icons.nix { inherit pkgs; };
  in
  {
    enable = true;
    iconTheme.package = nightfox-icons;
    iconTheme.name = "Duskfox";
    theme.package = pkgs.nordic;
    theme.name = "Nordic-darker";
  };
}
