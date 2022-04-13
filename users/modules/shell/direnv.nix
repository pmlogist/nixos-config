{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.shell.direnv;
in
{
  options.modules.shell.direnv = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      stdlib = ''
        use_flake() {
          watch_file shell.nix
          watch_file flake.nix
          watch_file flake.lock
          eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
        }
      '';
    };
  };
}
