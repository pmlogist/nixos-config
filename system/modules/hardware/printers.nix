{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.hardware.printers;
in
{
  options.modules.hardware.printers = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.printing.browsing = true;
    #services.printing.drivers = [ pkgs.utsushi ];

    # https://github.com/NixOS/nixpkgs/issues/118628
    services.avahi.nssmdns = false;
    system.nssModules = with pkgs.lib;
      optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
    system.nssDatabases.hosts = with pkgs.lib;
      optionals (!config.services.avahi.nssmdns) (mkMerge [
        (mkOrder 900
          [ "mdns4_minimal [NOTFOUND=return]" ]) # must be before resolve
        (mkOrder 1501 [ "mdns4" ]) # 1501 to ensure it's after dns
      ]);
  };

}
