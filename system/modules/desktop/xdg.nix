{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.xdg;
in
{
  options.modules.desktop.xdg = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      wlr = {
        enable = true;
        settings = {
          screencast = {
            max_fps = 30;
            chooser_type = "simple";
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          };
        };
      };
      gtkUsePortal = true;
    };
  };
}
