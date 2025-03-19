{
  description = "system flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
  };
  
  outputs = {self, nixpkgs, home-manager, nvf, ...}:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      customNeovim = nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./../config/nvf/nvf.nix ];
      };

    in {
    nixosConfigurations = {
      yourhostname = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          { networking.hostName = "yourhostname";}
          { users.users.usr = {
              isNormalUser = true;
              description = "usr";
              extraGroups = [ "networkmanager" "wheel" ];
            };
          }
          ./../hostHardware/yourhostname-hardware-configuration.nix
        ];
      };
      Big-boogaloo = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          {networking.hostName = "Big-boogaloo";}
          { users.users.viv = {
              isNormalUser = true;
              description = "viv";
              extraGroups = [ "networkmanager" "wheel" ];
            };
          }
          ./../hostHardware/Big-boogaloo-hardware-configuration.nix
        ];
      };
      Smol-boogaloo = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          {networking.hostName = "Smol-boogaloo";}
          { users.users.viv = {
              isNormalUser = true;
              description = "viv";
              extraGroups = [ "networkmanager" "wheel" ];
            };
          }
          ./../hostHardware/Smol-boogaloo-hardware-configuration.nix
        ];
      };
    };

    packages.${system}.my-neovim = customNeovim.neovim;

    homeConfigurations = {
      viv = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          ./../config/home-viv.nix
          {home.packages = [customNeovim.neovim];}
        ];
      };
    };
  };
}
