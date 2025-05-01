{ pkgs, lib, config, inputs, ... }:
{
  services.xserver.displayManager.sddm = {
    enable = true;
  };
}
