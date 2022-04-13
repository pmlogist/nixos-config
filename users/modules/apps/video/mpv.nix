{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.video.mpv;
in
{
  options.modules.apps.video.mpv = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    hardware-acceleration = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ffmpeg ];
    programs.mpv = {
      enable = true;
      config = {
        gpu-context = "wayland";
        save-position-on-quit = true;
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
      };
    };
  };
}
