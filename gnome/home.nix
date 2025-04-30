{ pkgs, lib, ... }:

{
  imports = [
    ./configuration/dconf.nix
    ./configuration/extensions.nix  
    # ./configuration/gtk.nix  
    ./configuration/inputs.nix  
  ];
}
