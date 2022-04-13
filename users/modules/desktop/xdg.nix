{ config, lib, stdenv, ... }:
let
  inherit (lib) mkIf mkOption types;
  inherit (stdenv) isDarwin;

  cfg = config.modules.desktop.xdg;
in
{
  options.modules.desktop.xdg = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    xdg.userDirs = rec {
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "$HOME/Pics/screenshots";
        XDG_WALLPAPERS_DIR = "$HOME/Pics/wallpapers";
        XDG_PROJECTS_DIR = "$HOME/Workspace";
      };
    };

    xdg.mimeApps =
      let
        apps = {
          fileBrowers = [ "org.gnome.Nautilus.desktop" ];
          web = [ "firefox.desktop" ];
          images = [ "org.gnome.eog.desktop" "gimp.desktop" ];
          videos = [ "mpv.desktop" "handbrake.desktop" ];
        };

        associations = {
          web = {
            "x-scheme-handler/http" = apps.web;
            "x-scheme-handler/https" = apps.web;
            "x-scheme-handler/chrome" = apps.web;
            "application/x-extension-htm" = apps.web;
            "application/x-extension-html" = apps.web;
            "application/x-extension-shtml" = apps.web;
            "application/xhtml+xml" = apps.web;
            "application/x-extension-xhtml" = apps.web;
            "application/x-extension-xht" = apps.web;
          };
        };
      in
      {
        enable = true;
        associations = { added = associations.web // { }; };
        defaultApplications = associations.web // {
          "text/html" = apps.web;
          "application/pdf" = [ "org.pwmt.zathura.desktop" ];
          "inode/directory" = apps.fileBrowers;
          "image/gif" = apps.images;
          "image/jpg" = apps.images;
          "image/jpeg" = apps.images;
          "image/png" = apps.images;
          "image/webp" = apps.images;
          "video/avi" = apps.videos;
          "video/flv" = apps.videos;
          "video/mp4" = apps.videos;
          "video/wmv" = apps.videos;
        };
      };

    home.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
      HISTFILE = "$XDG_DATA_HOME/bash/history";
      LESSHISTFILE = "$XDG_CACHE_HOME/lesshst";
      GOPATH = "$HOME/.go";
    };
  };
}
