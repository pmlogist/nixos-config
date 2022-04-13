{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.services.skhd;
  inherit (lib) mkIf mkOption types;
in
{
  options.modules.services.skhd = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        # Terminal
          shift + lalt - return : ~/.bin/open_iterm2.sh;

          lalt - return : yabai -m window --swap west # swap with "main" tile by simply swap it west

        # Focus window
          lalt - j : yabai -m window --focus next || yabai -m window --focus first
          lalt - k : yabai -m window --focus prev || yabai -m window --focus last

        # Swap window
          shift + lalt - j : yabai -m window --swap next
          shift + lalt - k : yabai -m window --swap prev

        # Rotating and axis
          lalt - r : yabai -m space --rotate 90
          lalt - y : yabai -m space --mirror y-axis
          lalt - x : yabai -m space --mirror x-axis
        # Focus space.
          lalt - 1 : yabai -m space --focus $(yabai -m query --displays --display mouse | jq -r '.spaces[0]');
          lalt - 2 : yabai -m space --focus $(yabai -m query --displays --display mouse | jq -r '.spaces[1]');
          lalt - 3 : yabai -m space --focus $(yabai -m query --displays --display mouse | jq -r '.spaces[2]');
          lalt - 4 : yabai -m space --focus $(yabai -m query --displays --display mouse | jq -r '.spaces[3]');
          lalt - 5 : yabai -m space --focus $(yabai -m query --displays --display mouse | jq -r '.spaces[4]');

        # Move window to spaces
          shift + lalt - 1 : yabai -m window --space $(yabai -m query --displays --display mouse | jq -r '.spaces[0]');
          shift + lalt - 2 : yabai -m window --space $(yabai -m query --displays --display mouse | jq -r '.spaces[1]');
          shift + lalt - 3 : yabai -m window --space $(yabai -m query --displays --display mouse | jq -r '.spaces[2]');
          shift + lalt - 4 : yabai -m window --space $(yabai -m query --displays --display mouse | jq -r '.spaces[3]');
          shift + lalt - 5 : yabai -m window --space $(yabai -m query --displays --display mouse | jq -r '.spaces[4]');

        # Toggle floating window and center
          shift + lalt - space : yabai -m window --toggle float;\
            yabai -m window --grid 4:4:1:1:2:2 
      '';
    };
  };
}
