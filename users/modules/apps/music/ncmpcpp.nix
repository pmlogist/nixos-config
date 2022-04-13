{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.music.ncmpcpp;
  mpd = config.modules.services.mpd;
in
{
  options.modules.apps.music.ncmpcpp = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
      mpdMusicDir = null;
    };
  };
}
