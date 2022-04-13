{ config, options, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkOption types;
  cfg = config.modules.apps.browser.chromium;
in
{
  options.modules.apps.browser.chromium = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--enable-features=WebRTCPipeWireCapturer"
      ];
    };
  };
}
