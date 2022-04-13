{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkMerge mkOption types;

  cfg = config.modules.hardware.graphics;
in
{
  options.modules.hardware.graphics = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    intel = {
      enable = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };

      hybrid-codec = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };
    };

    amd = {
      enable = mkOption {
        type = types.bool;
        example = true;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    modules.desktop.xdg.enable = true;
    modules.desktop.gtk.enable = true;

    programs.light.enable = true;

    #nixpkgs.config.packageOverrides = pkgs: {
    #  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    #};

    hardware.opengl =
      let
        intel = [ pkgs.intel-media-driver pkgs.libvdpau-va-gl ];
        amd = [ pkgs.amdvlk ];
      in
      {
        enable = true;
        extraPackages = [ pkgs.vaapiVdpau ]
          ++ (if cfg.intel.enable then intel else amd);
      };
  };

}
