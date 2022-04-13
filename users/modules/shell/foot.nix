{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.shell.foot;
in
{
  options.modules.shell.foot = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrains Mono Nerd Font:size=10.5";
          dpi-aware = "no";
        };

        mouse = { hide-when-typing = "yes"; };
        colors = { background = "1d1f21"; };
      };
    };
  };
}
