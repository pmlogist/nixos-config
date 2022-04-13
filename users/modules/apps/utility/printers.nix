{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.modules.apps.utility.printers;
in
{
  options.modules.apps.utility.printers = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ simple-scan ]; };

}
