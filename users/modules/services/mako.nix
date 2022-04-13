{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.services.mako;
in
{
  options.modules.services.mako = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ notify-desktop mako ];

    systemd.user.services.mako = {
      Unit = {
        Description = "Mako notification daemon";
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.mako}/bin/mako";
        RestartSec = 5;
        Restart = "always";
      };
    };
  };

}
