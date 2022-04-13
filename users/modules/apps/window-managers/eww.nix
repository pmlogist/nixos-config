{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.window-managers.eww;
in
{
  options.modules.apps.window-managers.eww = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    #programs.eww = { enable = true; }; 
    home.packages = [ pkgs.eww-wayland ];
  };
}
