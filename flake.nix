 {
   2 │   description = "NixOS config with zen-browser";
   3 │ 
   4 │   inputs = {
   5 │     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
   6 │     zen-browser.url = "github:0xc000022070/zen-browser-flake";
   7 │      mangowm = {
   8 │       url = "github:mangowm/mango";
   9 │       inputs.nixpkgs.follows = "nixpkgs";
  10 │     };
  11 │  };
  12 │ 
  13 │   outputs = { self, nixpkgs, mangowm, zen-browser, ... }: {
  14 │     nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
  15 │       system = "x86_64-linux";
  16 │       specialArgs = { inherit zen-browser mangowm; };
  17 │       modules = [
  18 │         ./configuration.nix
  19 │     mangowm.nixosModules.mango
  20 │       ];
  21 │     };
  22 │   };
  23 │ }
