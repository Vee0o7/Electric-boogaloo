install:

add user to nix.settings = {
  trusted-users = ["@wheel"];
  experimental-features = ["nix-command" "flakes"];
  };
  
add git and text editor of choice

ssh keygen add to github,
sops setup keys

nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/private > ~/.config/sops/age/keys.txt

nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt

add to sops secrets repo (add public age key to .sops.yaml)


copy hardware config, ensure still modular


sudo nixos-rebuild switch --flake .#HOSTNAME --accept-flake-config --sudo
