{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.modules.apps.utility.zathura;
in
{
  options.modules.apps.utility.zathura = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable { programs.zathura.enable = true; };

}
