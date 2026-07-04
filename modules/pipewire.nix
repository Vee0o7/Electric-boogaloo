{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.pipewire = {pkgs, ...}: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment the following
      #jack.enable = true;
    };
    services.pipewire.extraConfig.pipewire = {
      "98-crackling-fix" = {
        "context.properties" = {
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 1024;
          "default.clock.max-quantum" = 8192;
        };
      };
    };

    # additional fix for very bad devices or VM.
    services.pipewire.wireplumber.extraConfig = {
      "99-crackling-fix" = {
        "api.alsa.period-size" = 1024;
        "api.alsa.headroom" = 8192;
      };
    };
  };
}
