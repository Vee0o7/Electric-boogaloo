{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [./hardware-configuration.nix];
  networking.hostName = "Smol-boogaloo";
}
