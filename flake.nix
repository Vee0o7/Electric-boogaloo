{
  description = "system flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = {self, nixpkgs, home-manager, nixvim, stylix, ...} @ inputs:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      extra = {
        autologin = false;
        kb = "us";
      };
      distro = ./hypr;
      config = {extraInputs}: [
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
                inherit extraInputs;
              };
            }
      ];
    in {
    nixosConfigurations = {
      Big-boogaloo = let extraInputs = extra; in lib.nixosSystem {
        inherit system;
        specialArgs = { 
            inherit inputs;
            inherit extraInputs;
          };
        modules = [
          ./hostHardware/Big-boogaloo/configuration.nix
        ] ++ (config {inherit extraInputs;});
      };
      Smol-boogaloo = let extraInputs = (lib.attrsets.recursiveUpdate extra {autologin = true; kb = "gb";}); in lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit inputs;
            inherit extraInputs;
          };
        modules = [
          ./hostHardware/Smol-boogaloo/configuration.nix
        ] ++ (config {inherit extraInputs;});
      };
    };
  };
}
