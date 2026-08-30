install:

nix-shell git, vim

ssh keygen add to github
sops setup keys
nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/private > ~/.config/sops/age/keys.txt
nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt

add user to nix.settings.trusted-users

copy hardware config, ensure still modular


sudo nixos-rebuild switch --flake .#HOSTNAME
