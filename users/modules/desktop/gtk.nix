{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  inherit (pkgs.stdenv) mkDerivation;

  cfg = config.modules.desktop.gtk;

  cursor = cfg.cursor;
  font = cfg.font;
  icon = cfg.icon;
  theme = cfg.theme;
in
{
  options.modules.desktop.gtk = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };

    font = {
      sans = {
        name = mkOption {
          type = types.str;
          example = "Deja Vu";
          default = "SF Pro Text";
        };

        size = mkOption {
          type = types.int;
          example = "Deja Vu";
          default = 12;
        };
      };

      docs = {
        name = mkOption {
          type = types.str;
          example = "Deja Vu";
          default = "New York Medium";
        };

        size = mkOption {
          type = types.int;
          example = "Deja Vu";
          default = 12;
        };
      };

      mono = {
        name = mkOption {
          type = types.str;
          example = "Deja Vu";
          default = "JetBrainsMono Nerd Font";
        };

        size = mkOption {
          type = types.int;
          example = "Deja Vu";
          default = 11;
        };
      };
    };

    cursor = {
      theme-name = mkOption {
        type = types.str;
        example = "Adwaita";
        default = "macOSMonterey";
      };

      size = mkOption {
        type = types.int;
        example = true;
        default = 24;
      };
    };

    icon = {
      theme-name = {
        light = mkOption {
          type = types.str;
          example = "Adwaita";
          default = "Vimix";
        };

        dark = mkOption {
          type = types.str;
          example = "Adwaita";
          default = "Vimix";
        };
      };
    };

    theme = {
      theme-name = {
        light = mkOption {
          type = types.str;
          example = true;
          default = "Materia-light";
        };
        dark = mkOption {
          type = types.str;
          example = true;
          default = "Materia-dark";
        };
      };
    };
  };

  config = mkIf cfg.enable {

    home.sessionVariables = {
      GTK_CURRENT_THEME =
        "$(dconf read /org/gnome/desktop/interface/gtk-theme)";
      GTK_APPEARANCE = "dark";
      CURSOR_THEME = "${cursor.theme-name}";
      GTK_THEME_LIGHT = "${theme.theme-name.light}";
      GTK_THEME_DARK = "${theme.theme-name.dark}";
      ICON_THEME_LIGHT = "${icon.theme-name.light}";
      ICON_THEME_DARK = "${icon.theme-name.dark}";
    };

    gtk = {
      enable = true;
      font = {
        name = font.sans.name;
        size = font.sans.size;
      };
      iconTheme.name = icon.theme-name.dark;
      theme.name = theme.theme-name.dark;
      gtk2.extraConfig = ''
        gtk-cursor-theme-name="${cursor.theme-name}"
        gtk-cursor-theme-size="${toString cursor.size}"
        document-font-name="${font.docs.name} ${toString font.docs.size}"
        monospace-font-name="${font.mono.name} ${toString font.mono.size}"
      '';

      gtk3.extraConfig = {
        gtk-cursor-theme-name = cursor.theme-name;
        gtk-cursor-theme-size = cursor.size;
        document-font-name = "${font.docs.name} ${toString font.docs.size}";
        monospace-font-name = "${font.mono.name} ${toString font.mono.size}";
      };

      gtk4.extraConfig = {
        gtk-cursor-theme-name = cursor.theme-name;
        gtk-cursor-theme-size = cursor.size;
        document-font-name = "${font.docs.name} ${toString font.docs.size}";
        monospace-font-name = "${font.mono.name} ${toString font.mono.size}";
      };
    };
  };
}
