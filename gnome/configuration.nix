
{ pkgs, lib, config, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./../conf/configuration.nix
      ./gnome.nix
    ];
}
