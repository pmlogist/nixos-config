{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.editors.vscode;

in
{
  options.modules.apps.editors.vscode = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        #(makeDesktopItem {
        #  name = "vscode-wayland";
        #  desktopName = "VS Code Wayland";
        #  icon = "code";
        #  exec = "${vscode}/bin/code --enable-features=UseOzonePlatform --ozone-platform=wayland";
        #  categories = "Utility;TextEditor;Development;IDE";
        #})
      ];

    programs.vscode = { enable = true; };
  };
}
