{
  self,
  inputs,
  ...
}: {
  flake.homeModules.sops = {
    pkgs,
    config,
    lib,
    ...
  }: let
    sopsFolder = lib.toString inputs.sops-secrets;
  in {
    imports = [inputs.sops-nix.homeManagerModules.sops];

    home.packages = with pkgs; [
      sops
    ];
    systemd.user.services."rclone-proton.mount" = {
      Unit = {
        Description = "Mount proton drive via rclone";
        After = "network-online.target";
        Wants = "network-online.target";
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = {
        ExecStart = "${pkgs.writeShellScript "watch-store" ''
          #!/run/current-system/sw/bin/bash
          ${lib.getExe pkgs.rclone} mount proton: /home/viv/ProtonDrive --vfs-cache-mode writes --vfs-cache-max-size 500M --vfs-cache-max-age 1h --dir-cache-time 5m --poll-interval 1m --log-level INFO --umask 002 --allow-other
        ''}";
        ExecStop = "${builtins.toString pkgs.fuse3}/bin/fusermount3 -u /home/viv/ProtonDrive";
      };
    };
    sops = {
      defaultSopsFile = "${sopsFolder}/secrets.yaml";
      validateSopsFiles = false;
      defaultSopsFormat = "yaml";
      age = {
        keyFile = "/home/viv/.config/sops/age/keys.txt";
        # sshKeyPaths = ["/home/viv/.ssh/id_ed25519"];
        # generateKey = false;
      };

      secrets = {
        "gitKey" = {
          path = "/home/viv/.ssh/git";
        };
        "rcloneConf" = {
          path = "/home/viv/.config/rclone/rclone.conf";
        };
        passwdKey = {
          format = "binary";
          path = "/home/viv/.passwdKey";
          sopsFile = "${sopsFolder}/passwdKey";
        };
      };
    };
  };
}
