{ config, lib, pkgs, ... }:
lib.mkIf config.modules.desktop.sway.enable {
  home.packages = [
    (pkgs.writeShellScriptBin "app-search" ''
      j4-dmenu-desktop \
          --dmenu='bemenu -i -m $(swaymsg -r -t get_outputs | jq -r ". [] | select (.focused == true) | .name")' \
          --term='alacritty'
    '')
  ];
}
