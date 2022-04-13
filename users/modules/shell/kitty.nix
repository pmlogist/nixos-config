{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.shell.kitty;
in
{
  options.modules.shell.kitty = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.kitty.terminfo ];
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrains Mono Nerd Font";
        size = 10;
      };
      settings = {
        window_padding_width = 2;
        disable_ligatures = "always";
        allow_remote_control = true;
        enable_audio_bell = false;
      };
    };
  };
}
