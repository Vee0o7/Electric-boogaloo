
{ pkgs, lib, config, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./../config/configuration.nix
      ./gnome.nix
    ];
}
