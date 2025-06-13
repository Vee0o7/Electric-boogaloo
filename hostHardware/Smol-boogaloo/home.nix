{ config, osConfig, pkgs, nixvim, lib, ... }:

{

  home.packages = [
    pkgs.libnotify
    pkgs.upower
  ];
  systemd.user.services."low-charge-shutoff" = {
    Service.ExecStart = "/usr/bin/env bash -c ${./low-charge}";
  };
  systemd.user.timers."low-charge-shutoff" = {
    Install.wantedBy = [ "timers.target" ];
    Timer = {
      onBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "low-charge-shutoff.service";
    };
  };
}
