{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.graphics.inkscape;
in
{
  options.modules.apps.graphics.inkscape = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.inkscape ]; };
}
