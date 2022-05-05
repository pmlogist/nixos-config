{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.networking;
in {
  options.modules.networking = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    hostname = mkOption {
      type = types.str;
      example = "nixos";
      default = "nixos";
    };

    interfaces = {
      enp0s31f6 = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };

      wlp3s0 = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.powersave = false;
      };

      hostName = cfg.hostname;
      useDHCP = false;
      interfaces = mkIf cfg.interfaces.enp0s31f6 { enp0s31f6.useDHCP = true; };
    };

    services.openssh.enable = true;
    networking.firewall.allowedTCPPorts = [ 3000 5000 ];
  };
}
