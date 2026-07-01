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
      };
    };
  };
}
