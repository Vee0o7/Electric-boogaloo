{
  description = "system flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
  };
  
  outputs = {self, nixpkgs, home-manager, nixvim, stylix, ...}:
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
          ./../hostHardware/Big-boogaloo-hardware-configuration.nix
        ];
      };
      Smol-boogaloo = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          {networking.hostName = "Smol-boogaloo";}
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
          stylix.homeManagerModules.stylix
        ];
      };
    };
  };
}
