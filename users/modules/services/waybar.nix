{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.services.waybar;

  start-waybar = pkgs.writeShellScriptBin "start-waybar" ''
    export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -f 'sway$').sock
    ${pkgs.waybar}/bin/waybar
  '';
in
{
  options.modules.services.waybar = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ font-awesome pavucontrol playerctl ];

    programs.waybar =
      let
        battery = { name }: {
          bat = name;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        media = { number }: {
          format = "{icon} {}";
          return-type = "json";
          max-length = 55;
          format-icons = {
            Playing = "";
            Paused = "";
          };
          exec = "mediaplayer ${toString number}";
          exec-if = "[ $(playerctl -l 2>/dev/null | wc -l) -ge ${
            toString (number + 1)
          } ]";
          interval = 1;
          #on-click = "play-pause ${toString number}";
        };
      in
      {
        enable = true;
        settings = [{
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ ];
          modules-right =
            [ "cpu" "memory" "battery" "pulseaudio" "network" "clock" ];
          height = 28;
          layer = "bottom";
          #mode = "hide";
          #ipc = "true";
          modules = {
            "sway/workspaces" = {
              disable-scroll = true;
              format = "{icon}";
              format-icons = {
                "1" = "1";
                "2" = "2";
                "3" = "3";
                "4" = "4";
                "5" = "5";
                "6" = "6";
                "7" = "7";
                "8" = "8";
                "9" = "9";
                "0" = "0";
                "11" = "1";
                "12" = "2";
                "13" = "3";
                "14" = "4";
                "15" = "5";
                "16" = "6";
                "17" = "7";
                "18" = "8";
                "19" = "9";
                "10" = "0";
              };
            };
            "pulseaudio" = {
              format = "{icon}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = "";
              format-source = "{volume}% ";
              format-source-muted = "";
              format-icons = {
                "headphone" = "";
                "hands-free" = "";
                "headset" = "";
                "phone" = "";
                "portable" = "";
                "car" = "";
                "default" = [ "" "" "" ];
              };
              on-click = "pavucontrol";
            };
            "network" = {
              format-wifi = "";
              format-ethernet = "";
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "⚠";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
              tooltip = false;
            };
            "battery" = {
              states = {
                good = 95;
                warning = 95;
                critical = 95;
              };
              format = "{icon}";
              format-charging = "";
              format-plugged = "";
              format-alt = "{time} {icon}";
              format-icons = [ "" "" "" "" "" ];
            };
          };
        }];
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: "SF Pro Display", "Font Awesome 5 Free";
            font-size: 13px;
          }

          window#waybar {
            background-color: rgba(0,0,0,0);
            color: @theme_text_color;
            padding: 0 10px;
          }

          window#waybar.hidden {
            opacity: 0.2;
          }

          #waybar > .horizontal {
            padding: 5px 10px 0 10px;
          }


          #workspaces {
            background-color: alpha(@theme_unfocused_bg_color, 0.85);
            border: 1px solid alpha(@theme_text_color, 0.08);
            border-radius: 5px;
          }

          #workspaces button {
            border-radius: 5px;
            padding: 2px 2px;
            margin: 2px;
          }

          #workspaces button:hover {
            background-color: alpha(@theme_text_color, 0.08);
            box-shadow: inherit;
            text-shadow: inherit;
          }

          #workspaces button.focused {
            color: @theme_base_color;
            background-color: @theme_text_color;
          }

          #workspaces button:hover.focused {
            color: inherit;
            background-color: inherit;
          }

          #mode {
            margin: 5px 0 0 10px;
            padding: 0 5px;
            border-radius: 5px;
          }

          #window {
            font-weight: 600;
            margin: 5px 0 0 10px;
          }

          .modules-right {
            background-color: alpha(@theme_unfocused_bg_color, 0.85);
            border: 1px solid alpha(@theme_text_color, 0.08);
            border-radius: 5px;
          }

          #tray,
          #pulseaudio,
          #network,
          #memory,
          #cpu,
          #backlight,
          #battery,
          #clock,
          #custom-media,
          #custom-power {
            margin: 0 6px;
          }

          #pulseaudio.hover {
            background-color:red;
          }

          #backlight {
            font-size: 15px;
          }

          #custom-media {
            min-width: 50px;
            margin: 5px 0 0 10px;
          }

          #custom-media:nth-child(2) {
            margin-right: 5px;
          }
        '';
      };

    systemd.user.services.waybar = {
      Unit = {
        Description = "Wayland bar for Sway and Wlroots based compositors";
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        Type = "simple";
        ExecStart = "${start-waybar}/bin/start-waybar";
        RestartSec = 5;
        Restart = "always";
      };
    };
  };

}
