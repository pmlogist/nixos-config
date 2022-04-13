{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.virtualisation.docker;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.virtualisation.docker = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    systemd.services = {
      kill-all-docker-containers = {
        description = "Kill all docker containers to prevent shutdown lag";
        enable = true;
        unitConfig = {
          DefaultDependencies = false;
          RequiresMountFor = "/";
        };
        before =
          [ "shutdown.target" "reboot.target" "halt.target" "final.target" ];
        wantedBy =
          [ "shutdown.target" "reboot.target" "halt.target" "final.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = pkgs.writeScript "docker-kill-all" ''
            #! ${pkgs.runtimeShell} -e
            ${pkgs.docker}/bin/docker ps --format '{{.ID}}' | xargs ${pkgs.docker}/bin/docker kill
          '';
        };
      };
    };
  };
}
