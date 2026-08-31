{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.vpn = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      openvpn
      qbittorrent
    ];
  };
}
