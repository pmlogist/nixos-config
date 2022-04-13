{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.fonts;

in
{
  options.modules.desktop.fonts = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    jetbrains-mono = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    apple = {
      fonts = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };
      emoji = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (mkIf cfg.jetbrains-mono jetbrains-mono)
      (mkIf cfg.apple.fonts apple-fonts)
      (mkIf cfg.apple.emoji apple-emoji)
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      noto-fonts-cjk
    ];
  };
}
