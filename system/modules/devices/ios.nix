{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.devices.ios;
in
{
  options.modules.devices.ios = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.usbmuxd.enable = true;
    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse # optional, to mount using 'ifuse'
    ];
  };

}

