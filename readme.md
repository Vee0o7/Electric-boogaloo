To setup on a fresh install:

  1- edit /etc/nixos/configuration to add git and flakes
  
    git to environment.systemPackages
    nix.settings.experimental-features = ["nix-command" "flakes"]; # to enable flakes
  2- run
  
    sudo nixos-rebuild switch
    
  3- clone this repo wherever you want to keep it (I have mine in ~/.dotfiles)
     pick a desktop environment to use and add your hostname to the flake.nix config (copy existing structure and change the name)
     then in that directory run: 
    
     sudo nixos-rebuild switch --flake .#yourhostname

from now on you can run the sync.sh bash script provided (./sync.sh -h for more info)
rebuild installs packages in configuration onto the system
home-manager (default sync option) installs user packages
