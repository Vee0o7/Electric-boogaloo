{ pkgs, lib, ... }:

{
  imports = [
    ./../config/home.nix
    ./configuration/dconf.nix
    ./configuration/extensions.nix  
    ./configuration/gtk.nix  
    ./configuration/inputs.nix  
  ];
  home.file = {
    ".gnomerc".source = ./../config/startup;
  };
}
