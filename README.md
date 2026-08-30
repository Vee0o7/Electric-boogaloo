install:

nix-shell git, vim

ssh keygen add to github
add user to nix.settings.trusted-users

copy hardware config, ensure still modular


sudo nixos-rebuild switch --flake .#HOSTNAME
