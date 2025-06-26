{...}:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire-pulse = {
      "shared-sink-loop" = {
        "pulse.cmd" = [
          {cmd = "load-module"; args = "module-null-sink sink_name=shared";}
          {cmd = "load-module"; args = "module-loopback sink=alsa_output.pci-0000_00_1f.3.analog-stereo source=shared.monitor";}
          # {cmd = "load-module"; args= "module-loopback sink=alsa_output.usb-Razer_Razer_BlackShark_V2_Pro-00.iec958-stereo source=shared.monitor sink_dont_move=true";}
        ];
      };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
