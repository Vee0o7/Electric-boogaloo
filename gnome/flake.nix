{
  description = "system flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = {self, nixpkgs, home-manager, nixvim, ...}:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
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

    homeConfigurations = {
      viv = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}
