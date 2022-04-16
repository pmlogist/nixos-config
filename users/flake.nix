{
  description = "Home Manager flake";

  inputs = {
    nur.url = "github:nix-community/NUR";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, unstable, ... }@inputs:
    let
      mkPkgs = pkgs: overlays:
        import pkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [ "electron-11.5.0" ];
          };

          overlays = overlays ++ [
            (import ./packages/apple-cursors.nix)
            (import ./packages/apple-emoji.nix)
            (import ./packages/apple-fonts.nix)
            (import ./packages/swaysome.nix)
            (import ./overlays)
            inputs.neovim-nightly.overlay
            inputs.nur.overlay
          ];
        };
    in inputs.flake-utils.lib.eachDefaultSystem
    (system: { legacyPackages = inputs.unstable.legacyPackages.${system}; })
    // {
      homeConfigurations = let
        pkgs = mkPkgs unstable [ ];
        username = "pmlogist";
      in {
        magda = let system = "x86_64-linux";
        in inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs system username;
          homeDirectory = "/home/pmlogist";
          configuration = {
            imports = [ ./home/magda.nix ] ++ (import ./modules)
              ++ (import ./bin);
          };
        };

        #profiterole = inputs.home-manager.lib.homeManagerConfiguration {
        #  system = "x86_64-linux";
        #  homeDirectory = "/home/pmlogist";
        #  username = "pmlogist";
        #  pkgs = mkPkgs nixpkgs [ ];
        #  configuration = { config, lib, pkgs, ... }: {
        #    imports = [ ./home/profiterole.nix ] ++ (import ./modules)
        #      ++ (import ./bin);
        #  };
        #};

        alena = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          homeDirectory = "/Users/pmlogist";
          username = "pmlogist";
          pkgs = import unstable {
            system = "x86_64-darwin";

            config = {
              allowUnfree = true;
              permittedInsecurePackages = [ "electron-11.5.0" ];
            };

            overlays = [
              (import ./packages/apple-cursors.nix)
              (import ./packages/apple-emoji.nix)
              (import ./packages/apple-fonts.nix)

              inputs.neovim-nightly.overlay
            ];

          };
          configuration = { config, lib, pkgs, ... }: {
            imports = [
              ./modules/apps/video/mpv.nix
              ./modules/apps/editors/neovim.nix

              ./modules/desktop/fonts.nix

              ./modules/dev/insomnia.nix
              ./modules/dev/git.nix

              ./modules/shell/direnv.nix
              ./modules/shell/tmux.nix
              ./modules/shell/zsh.nix

              ./home/alena.nix
            ];
          };
        };
      };
    };
}
