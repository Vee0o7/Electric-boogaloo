{ pkgs, lib, ... }:

{
  imports = [
    ./../conf/home.nix
    ./gnome-conf.nix
  ];
}
