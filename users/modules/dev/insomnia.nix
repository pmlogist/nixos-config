{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.dev.insomnia;
  inherit (lib) mkIf mkOption types;

in
{
  options.modules.dev.insomnia = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.insomnia ]; };
}
