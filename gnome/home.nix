{ pkgs, lib, ... }:

{
  imports = [
    ./../conf/home.nix
    ./configuration/dconf.nix
    ./configuration/extensions.nix  
    ./configuration/gtk.nix  
    ./configuration/inputs.nix  
  ];
}
