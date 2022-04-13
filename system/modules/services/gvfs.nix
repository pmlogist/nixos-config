{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.services.gvfs;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.services.gvfs = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  # https://nixos.wiki/wiki/Nautilus
  config = mkIf cfg.enable { services.gvfs.enable = true; };
}
