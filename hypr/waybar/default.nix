{...}:
{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = import ./config.nix;
  };
}
