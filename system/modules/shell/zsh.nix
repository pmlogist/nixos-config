{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.shell.zsh;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.shell.zsh = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    users.defaultUserShell = pkgs.zsh;

  };
}
