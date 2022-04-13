{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.misc.gnu;
in
{
  options.modules.misc.gnu = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      imagemagick
      ffmpeg
      killall
      iptables
      jq
      lsof
      nmap
      p7zip
      pciutils
      pfetch
      stow
      unzip
      unrar
    ];
  };
}
