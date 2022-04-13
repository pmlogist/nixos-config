{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.virtualisation.virtualbox;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.virtualisation.virtualbox = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    users.extraGroups.vboxusers.members = [ "pmlogist" ];
    virtualisation.virtualbox.host.enable = true;
    #virtualisation.virtualbox.host.enableExtensionPack = true;
  };
}
