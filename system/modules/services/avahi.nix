{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.services.avahi;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.services.avahi = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns = false;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };

  };
}
