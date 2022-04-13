{ config, options, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge mkOption types;
  cfg = config.modules.apps.browser.firefox;
in
{
  options.modules.apps.browser.firefox = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        forceWayland = true;
        extraPolicies = { ExtensionSettings = { }; };
        cfg = { enableGnomeExtensions = true; };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        betterttv
      ];
      profiles =
        let
          defaultSettings = {
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
            "security.sandbox.content.level" = 0;
            "media.navigator.mediadatadecoder_vpx_enabled" = true;
          };
        in
        {
          pmlogist = {
            id = 0;
            path = "pmlogist";
            settings = defaultSettings // { };
          };

          enclosure = {
            id = 1;
            path = "enclosure";
            settings = defaultSettings // { };
          };

          work = {
            id = 2;
            path = "work";
            settings = defaultSettings // { };
          };

        };
    };
  };
}
