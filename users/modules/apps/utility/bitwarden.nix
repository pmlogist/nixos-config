{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.modules.apps.utility.bitwarden;
in
{
  options.modules.apps.utility.bitwarden = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        #bitwarden
        (bitwarden.overrideAttrs (oldAttrs: rec {
          desktopItem = oldAttrs.desktopItem // {
            exec = "NIXOS_WL=1 bitwarden %U";
          };
        }))
      ];
  };

}
