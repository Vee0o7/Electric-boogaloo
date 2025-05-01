{...}:
{
  imports = [./hardware-configuration.nix];
  networking.hostName = "Smol-boogaloo";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  # # power saving settings
  # services.power-profiles-daemon.enable = false;
  # powerManagement.enable = true;
  # services.thermald.enable = true;
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #
  #     CPU_MIN_PERF_ON_BAT = 0;
  #     CPU_MAX_PERF_ON_BAT = 55;
  #     CPU_MIN_PERF_ON_AC = 0;
  #     CPU_MAX_PERF_ON_AC = 100;
  #
  #     #Optional helps save long term battery health
  #     START_CHARGE_THRESH_BAT0 = 60;
  #     STOP_CHARGE_THRESH_BAT0 = 80;
  #   };
  # };
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
