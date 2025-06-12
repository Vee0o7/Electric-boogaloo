{ config, osConfig, pkgs, nixvim, lib, ... }:

{

  systemd.user.services."low-charge-shutoff" = {
    Service.ExecStart = "bash ${./low-charge}";
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
