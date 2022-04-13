{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.services.mpd;
in
{
  options.modules.services.mpd = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    modules.apps.music.ncmpcpp.enable = true;
    home.packages = [ pkgs.mpc_cli ];
    services.mpd = {
      enable = true;
      musicDirectory = "~/Music";
      extraConfig = ''
        audio_output {
          type "pipewire" 
          name "PipeWire Sound Server" 
        }
      '';
    };
    services.mpdris2 = {
      enable = true;
      mpd = { musicDirectory = null; };
    };
  };
}
