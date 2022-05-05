{ config, lib, pkgs, ... }: {

  modules = {
    desktop = {
      fonts = {
        enable = true;
        jetbrains-mono = true;
        apple = {
          #emoji = true;
          fonts = true;
        };
      };
      dconf.enable = true;
    };
    apps = {
      browser = {
        firefox.enable = true;
        chromium.enable = true;
      };
      editors = {
        vscode.enable = true;
        neovim.enable = true;
      };
      graphics = {
        gimp.enable = true;
        #   imv.enable = true;
        #   inkscape.enable = true;
      };
      networking = { discord.enable = true; };
      utility = {
        bitwarden.enable = true;
        #   printers.enable = true;
        #   #zathura.enable = true;
      };
      video = {
        handbrake.enable = true;
        mpv = {
          enable = true;
          hardware-acceleration = true;
        };
      };
      # window-managers = { eww.enable = true; };
    };
    dev = {
      #insomnia.enable = true;
      git.enable = true;
    };
    services = { mpd.enable = true; };
    shell = {
      alacritty.enable = true;
      bat.enable = true;
      direnv.enable = true;
      #  kitty.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    ulauncher

    (pkgs.writeShellScriptBin "switch-theme" ''
      CURRENT_GTK_THEME="$(dconf read /org/gnome/desktop/interface/color-scheme)"

      if [ $CURRENT_GTK_THEME == "'prefer-dark'" ]
      then
        dconf write /org/gnome/desktop/interface/color-scheme '"default"';
        dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita"';
      else
        dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"';
        dconf write /org/gnome/desktop/interface/gtk-theme '"Adwaita-dark"';
      fi
    '')
  ];
  programs.home-manager.enable = true;
}
