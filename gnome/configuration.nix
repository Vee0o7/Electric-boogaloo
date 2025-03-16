
{ pkgs, lib, config, ... }: 

{
  imports =
    [ # Include the results of the hardware scan.
      ./../hostHardware/home-hardware-configuration.nix
      ./../conf/configuration.nix
      ./gnome.nix
    ];
}
