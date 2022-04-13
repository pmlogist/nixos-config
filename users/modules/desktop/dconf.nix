{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  inherit (lib.hm) gvariant;

  cfg = config.modules.desktop.dconf;
in {
  options.modules.desktop.dconf = {
    enable = mkOption {
      type = lib.types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lounge-gtk-theme
      apple-cursors
      dconf
      gnome.dconf-editor
      vimix-icon-theme
      materia-theme
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        clock-show-date = true;
        color-scheme = "prefer-dark";
        cursor-size = 24;
        cursor-theme = "macOSMonterey";
        document-font-name = "New York Medium, 12";
        enable-hot-corners = false;
        font-antialiasing = "rgba";
        font-hinting = "slight";
        font-name = "SF Pro Text 12";
        gtk-theme = "Adwaita-dark";
        icon-theme = "Vimix";
        monospace-font-name = "JetBrainsMono Nerd Font 10";
        overlay-scrolling = 1;
        text-scaling-factor = 1.0;
      };

      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        center-new-windows = true;
        dynamic-workspaces = false;
        edge-tiling = true;
        experimental-features = [ "scale-monitor-framebuffer" ];
        focus-change-on-pointer-rest = true;
        overlay-key = "";
        workspaces-only-on-primary = true;
      };

      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ ];
        toggle-tiled-right = [ ];
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-and-drag = false;
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/wm/keybindings" = with gvariant; {
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-6 = [ "<Super><Shift>6" ];
        move-to-workspace-7 = [ "<Super><Shift>7" ];
        move-to-workspace-8 = [ "<Super><Shift>8" ];
        move-to-workspace-9 = [ "<Super><Shift>9" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];
      };

      "org/gnome/shell/keybindings" = with gvariant; {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
        switch-monitor = [ ];
        toggle-application-view = [ "<Super>p" ];
      };

      "org/gnome/nautilus/icon-view" = { default-zoom-level = "large"; };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        search-filter-time-type = "last_modified";
        search-view = "list-view";
        show-delete-permanently = false;
        show-image-thumbnails = "always";
      };

      "org/gnome/nautilus/window-state" = with gvariant; {
        initial-size = mkTuple [ 900 600 ];
        maximized = false;
        sidebar-width = 170;
      };

      "org/gtk/settings/file-chooser" = with gvariant; {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        show-size-column = true;
        show-type-column = true;
        sidebar-width = 170;
        sort-column = "name";
        sort-directories-first = true;
        sort-order = "descending";
        type-format = "category";
        window-position = mkTuple [ 56 50 ];
        window-size = mkTuple [ 960 500 ];
      };

      # Extensions
      "org/gnome/shell/extensions/appindicator" = { tray-pos = "right"; };

      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [ ];
      };

      "org/gtk/gtk4/settings/file-chooser" = with gvariant; {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        show-size-column = true;
        show-type-column = true;
        sidebar-width = 200;
        sort-column = "name";
        sort-directories-first = false;
        sort-order = "ascending";
        type-format = "category";
        window-size = mkTuple [ 950 600 ];
      };

      "org/gnome/shell/extensions/pop-shell" = {
        active-hint = false;
        smart-gaps = false;
        snap-to-grid = false;
        tile-by-default = true;
      };
    };
  };
}
