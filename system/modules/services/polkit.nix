{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.services.polkit;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.services.polkit = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [ pkgs.polkit ];

    security.polkit.enable = true;
    environment.pathsToLink = [ "/libexec" ];

  };
}
