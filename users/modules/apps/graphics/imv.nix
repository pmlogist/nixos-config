{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.graphics.imv;
in
{
  options.modules.apps.graphics.imv = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.imv ];
  };
}
