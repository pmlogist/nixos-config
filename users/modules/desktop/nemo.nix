{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.nemo;

in
{
  options.modules.desktop.nemo = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ cinnamon.nemo ffmpegthumbnailer ];
  };
}
