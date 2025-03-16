{
  description = "system flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
  };
  
  outputs = {self, nixpkgs, home-manager, nvf, ...}@inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      customNeovim = nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./nvf.nix ];
      };

    in {
    nixosConfigurations = {
      Electric-boogaloo = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
        ];
      };
    };

    packages.${system}.my-neovim = customNeovim.neovim;

    homeConfigurations = {
      viv = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          {home.packages = [customNeovim.neovim];}
        ];
      };
    };
  };
}
