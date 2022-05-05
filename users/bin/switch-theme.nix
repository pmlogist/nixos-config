{ config, lib, pkgs, ... }:
lib.mkIf config.modules.desktop.gtk.enable {
  #home.packages = [
  #  (pkgs.writeShellScriptBin "switch-theme" ''
  #    CURRENT_GTK_THEME="$(dconf read /org/gnome/desktop/interface/gtk-theme)"

  #    if [ $CURRENT_GTK_THEME == "'$GTK_THEME_DARK'" ]
  #    then
  #        dconf write /org/gnome/desktop/interface/gtk-theme "'$GTK_THEME_LIGHT'"
  #        dconf write /org/gnome/desktop/interface/icon-theme "'$ICON_THEME_LIGHT'"
  #        ${
  #          if config.modules.shell.kitty.enable then ''
  #            kitty @ set-colors -a -c $XDG_CONFIG_HOME/kitty/colors/tomorrow.conf
  #          '' else
  #            ""
  #        }
  #    else
  #        dconf write /org/gnome/desktop/interface/gtk-theme "'$GTK_THEME_DARK'"
  #        dconf write /org/gnome/desktop/interface/icon-theme "'$ICON_THEME_DARK'"
  #        ${
  #          if config.modules.shell.kitty.enable then ''
  #            kitty @ set-colors -a -c $XDG_CONFIG_HOME/kitty/colors/tomorrow-night.conf
  #          '' else
  #            ""
  #        }
  #    fi
  #  '')
  #];
}
