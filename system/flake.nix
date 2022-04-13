{
  description = "system configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, darwin, nixpkgs, ... }:
    let
      mkPkgs = pkgs: overlays:
        import pkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [ "electron-13.6.9" ];
          };
          overlays = overlays;
        };
    in inputs.flake-utils.lib.eachDefaultSystem
    (system: { legacyPackages = inputs.nixpkgs.legacyPackages.${system}; }) // {
      darwinConfigurations = {
        alena = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./hosts/alena
            ./modules/services/yabai.nix
            ./modules/services/skhd.nix
          ];
        };
      };

      nixosConfigurations = {
        magda = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs nixpkgs [ ];
          modules = [
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
            ./hosts/magda
            ./users.nix
          ] ++ import ./modules;
        };

        yuliya = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs nixpkgs [ ];
          modules = [
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t440p
            ./hosts/yuliya
            ./users.nix
          ] ++ import ./modules;
        };
      };
    };
}
