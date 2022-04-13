{ config, lib, options, pkgs, ... }:

let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.sway;
  cursor = config.modules.desktop.gtk.cursor;

in
{
  options.modules.desktop.sway = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    config = {
      modifier = mkOption {
        type = types.str;
        example = true;
        default = "Mod4";
      };

      ctrl = mkOption {
        type = types.str;
        example = true;
        default = "ctrl";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      with pkgs.sway-contrib; [
        bemenu
        swaylock
        swaybg
        swayidle
        swaysome

        grimshot

        wl-clipboard
        autotiling
        xwayland
        pulseaudio
        polkit_gnome
      ];

    # TODO: implementation for swaylock + swayidle in different modules
    modules.desktop.gtk.enable = true;
    modules.desktop.xdg.enable = true;
    modules.misc.gnu.enable = true;
    modules.services.mako.enable = true;
    modules.services.kanshi.enable = true;
    modules.services.waybar.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      xwayland = true;

      config = rec {
        # TODO  options for mod key
        modifier = cfg.config.modifier;
        # TODO: options for terminals, 
        terminal = "kitty --single-instance";
        bars = [ ];
        input = {
          "type:keyboard" = {
            xkb_layout = "us,ru";
            xkb_variant = "altgr-intl,";
            xkb_options = "grp:alt_caps_toggle";
            xkb_numlock = "enabled";
          };
          "type:touchpad" = {
            dwt = "true";
            tap = "enabled";
            drag = "disabled";
            natural_scroll = "enabled";
            scroll_method = "two_finger";
          };
        };
        floating = {
          criteria = [
            { app_id = "pavucontrol"; }
            { title = "Firefox — Sharing Indicator"; }
          ];
        };
        # TODO: Change wallpaper depending of the theme + runtime wallpaper with imw
        output."*" = { bg = "$HOME/Pics/wallpapers/bg-dark.jpg fill"; };
        keybindings =
          let
            modKey = cfg.config.modifier;
            ctrlKey = cfg.config.ctrl;
          in
          lib.mkOptionDefault {
            # Control volume
            XF86AudioRaiseVolume =
              "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
            XF86AudioLowerVolume =
              "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
            XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            XF86AudioMicMute =
              "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            # Control media
            XF86AudioPlay = "exec playerctl play-pause";
            XF86AudioPause = "exec playerctl play-pause";
            XF86AudioNext = "exec playerctl next";
            XF86AudioPrev = "exec playerctl previous";
            # Control brightness
            XF86MonBrightnessUp = "exec light -A 10";
            XF86MonBrightnessDown = "exec light -U 10";
            "${modKey}+p" = "exec app-search";
            # Swaysome
            "${modKey}+1" = "exec swaysome focus 1";
            "${modKey}+2" = "exec swaysome focus 2";
            "${modKey}+3" = "exec swaysome focus 3";
            "${modKey}+4" = "exec swaysome focus 4";
            "${modKey}+5" = "exec swaysome focus 5";
            "${modKey}+6" = "exec swaysome focus 6";
            "${modKey}+7" = "exec swaysome focus 7";
            "${modKey}+8" = "exec swaysome focus 8";
            "${modKey}+9" = "exec swaysome focus 9";
            "${modKey}+Shift+1" = "exec swaysome move 1";
            "${modKey}+Shift+2" = "exec swaysome move 2";
            "${modKey}+Shift+3" = "exec swaysome move 3";
            "${modKey}+Shift+4" = "exec swaysome move 4";
            "${modKey}+Shift+5" = "exec swaysome move 5";
            "${modKey}+Shift+6" = "exec swaysome move 6";
            "${modKey}+Shift+7" = "exec swaysome move 7";
            "${modKey}+Shift+8" = "exec swaysome move 8";
            "${modKey}+Shift+9" = "exec swaysome move 9";
            "${modKey}+o" = "exec swaysome next_output";
            "${modKey}+Shift+o" = "exec swaysome prev_output";
            # Grimshot
            "${ctrlKey}+Shift+1" = "exec grimshot --notify save active";
            "${ctrlKey}+Shift+2" = "exec grimshot --notify save area";
            "${ctrlKey}+Shift+3" = "exec grimshot --notify save window";
          };
        gaps = {
          inner = 5;
          horizontal = 5;
        };
      };
      extraSessionCommands = ''
        #export XDG_SESSION_TYPE=wayland
        #export XDG_SESSION_DESKTOP=sway
        #export XDG_CURRENT_DESKTOP=sway
        export MOZ_ENABLE_WAYLAND=1
      '';
      extraConfig = ''
        default_border pixel 1

        seat seat0 xcursor_theme "${cursor.theme-name}" "${
          toString cursor.size
        }"
        exec ~/.nix-profile/libexec/polkit-gnome-authentication-agent-1
        exec "swaysome init 1"
        exec autotiling
        exec systemctl --user restart waybar.service 
        exec systemctl --user restart kanshi.service
        exec systemctl --user restart xdg-desktop-portal.service 
        exec systemctl --user restart xdg-desktop-portal-wlr.service 
      '';
    };
  };
}
