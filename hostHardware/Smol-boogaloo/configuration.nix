{pkgs, ...}:
{
  imports = [./hardware-configuration.nix];
  networking.hostName = "Smol-boogaloo";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  # power saving settings
  services.power-profiles-daemon.enable = false;
  # powerManagement.enable = true;
  # services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 55;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 0;
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };

  systemd.timers."sleep-low-charge" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "sleep-low-charge.service"; 
    };
  };
  systemd.services."sleep-low-charge" = {
    script = ''
      BAT=$(${pkgs.upower}/bin/upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage" | grep -oP "[0-9]+")
      ${pkgs.libnotify}/bin/notify-send -u critical -t 0 "Critical battery: shutdown in 5 minutes" -a "System"
      (sleep 240; gnome-session-quit --power-off) &
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  services.displayManager.autoLogin = {
    enable = true;
    user = "viv";
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
