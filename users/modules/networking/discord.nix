{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.networking.discord;
in
{
  options.modules.apps.networking.discord = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        #discord
        (makeDesktopItem {
          name = "discord-chromium";
          desktopName = "Discord Chromium";
          icon = "discord";
          exec =
            "${pkgs.chromium}/bin/chromium --profile-directory=Default --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-accelerated-mjpeg-decode --enable-accelerated-video --ignore-gpu-blacklist --enable-native-gpu-memory-buffers --enable-gpu-rasterization --enable-gpu --enable-features=WebRTCPipeWireCapturer  --app=https://discord.com/app";
          categories = [ "Network" ];
        })

      ];
  };
}
