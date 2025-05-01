{
  description = "system flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprspace = {
      url = "github:KZDKM/Hyprspace";

      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = {self, nixpkgs, home-manager, nixvim, stylix, nixpkgs-unstable, ...} @ inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      distro = ./gnome;
      config = [
          (distro + "/configuration.nix")

          ./config/configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.viv = {imports = [(distro + "/home.nix") ./config/home.nix];};
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = {
                inherit nixvim;
                inherit inputs;
              };
            }
      ];
    in {
    nixosConfigurations = {
      Big-boogaloo = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hostHardware/Big-boogaloo/configuration.nix
        ] ++ config;
      };
      Smol-boogaloo = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ 
          ./hostHardware/Smol-boogaloo/configuration.nix
        ] ++ config;
      };
    };
  };
}
