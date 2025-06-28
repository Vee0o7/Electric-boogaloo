{osConfig, config, ...}:
{
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        volume_normalisation = true;
        bitrate = 320;
        # device = "shared";
        # device_name = "spotifyd";
        initial_volume = 70;
      };
    };
  };

  programs.spotify-player = {
    enable = true;
    keymaps = [
      # {command = "None"; key_sequence = "q";}
      {command.VolumeChange.offset = 5; key_sequence  = "=";}
    ];
    settings = {
      enable_streaming = false;
      client_id_command = { command = "cat"; args = ["${config.home.homeDirectory}/.spotifyid"];};
      default_device = ''Spotifyd@${osConfig.networking.hostName}'';
    };
  };
}
