{...}:
{
  stylix.targets.waybar = {
    enableCenterBackColors = true;
    enableLeftBackColors = true;
    enableRightBackColors = true;
    addCss = false;
  };
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = import ./config.nix;
  };
}
