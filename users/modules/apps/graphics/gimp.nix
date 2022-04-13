{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.graphics.gimp;
in
{
  options.modules.apps.graphics.gimp = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.gimp ]; };
}
