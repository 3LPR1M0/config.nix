{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangobar = {
      url = "github:mangowm/mangobar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, mangowm, mangobar, ... }@inputs: let
    inherit (nixpkgs) lib;
  in {
    nixosConfigurations.nixos-btw = lib.nixosSystem {
      system = "x86_64-linux";   # change if you're on aarch64
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        mangowm.nixosModules.mango
	({ pkgs, ... }: {
          environment.systemPackages = [
            mangobar.packages.${pkgs.stdenv.hostPlatform.system}.mangobar
          ];
        })
      ];
    };
  };
}
