{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.services.kanshi;
in
{
  options.modules.services.kanshi = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.kanshi = {
      enable = true;
      profiles = {
        home.outputs = [
          {
            criteria = "eDP-1";
            mode = "3840x2160";
            position = "0,0";
            scale = 2.0;

          }
          {
            criteria = "Ancor Communications Inc ASUS VP229 G8LMTF086976";
            mode = "1920x1080";
            position = "1920,0";
            scale = 1.0;
          }
        ];
        vm.outputs = [{
          criteria = "virtual-1";
          mode = "1024x768";
        }];
      };
    };
  };

}
