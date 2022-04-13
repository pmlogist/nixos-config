{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.gtk;
in
{
  options.modules.desktop.gtk = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.light.enable = true;

    environment.systemPackages = with pkgs; [
      gtk-engine-murrine
      gtk_engines
      gsettings-desktop-schemas
    ];
  };

}
