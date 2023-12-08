{
  description = "poachers flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim.url = "github:nix-community/nixvim";

    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, home-manager, nixvim, ags, ... } @ inputs: 
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./universal/nixos/configuration.nix
          ./laptop/nixos/configuration.nix
          ./laptop/nixos/hardware-configuration.nix
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./universal/nixos/configuration.nix
          ./desktop/nixos/configuration.nix
          ./desktop/nixos/hardware-configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          nixvim.homeManagerModules.nixvim
          ags.homeManagerModules.default
          ./universal/home-manager/home.nix
          ./laptop/home-manager/home.nix
        ];
      };

      "desktop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
          ./universal/home-manager/home.nix 
          ./desktop/home-manager/home.nix
        ];
      };
    };
  };
}

