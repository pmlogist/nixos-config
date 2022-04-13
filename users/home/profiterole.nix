{ config, lib, pkgs, ... }: {

  modules = {
    desktop = {
      nautilus.enable = true;
      sway.enable = true;
      fonts = {
        enable = true;
        jetbrains-mono = true;
        apple = {
          emoji = false;
          fonts = true;
        };
      };
    };
    apps = {
      browser = {
        firefox.enable = true;
        chromium.enable = false;
      };
      editors = { };
      graphics = {
        gimp.enable = true;
        imv.enable = true;
        inkscape.enable = true;
      };
      networking = { discord.enable = true; };
      utility = {
        bitwarden.enable = true;
        printers.enable = true;
        zathura.enable = true;
      };
      video = {
        handbrake.enable = true;
        mpv = {
          enable = true;
          hardware-acceleration = true;
        };
      };
      window-managers = { eww.enable = true; };
    };
    dev = {
      insomnia.enable = true;
      git.enable = true;
      neovim.enable = true;
    };
    services = { mpd.enable = true; };
    shell = {
      bat.enable = true;
      direnv.enable = true;
      kitty.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };

  home.packages = with pkgs; [ j4-dmenu-desktop docker ];
}
