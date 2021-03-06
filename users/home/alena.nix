{ config, lib, pkgs, ... }: {

  programs.home-manager.enable = true;
  programs.kitty.enable = true;
  programs.kitty.darwinLaunchOptions = [ "--single-instance" ];
  modules = {
    desktop = {
      fonts = {
        enable = true;
        jetbrains-mono = true;
      };
    };
    apps = {
      #  browser = {
      #    firefox.enable = true;
      #    chromium.enable = true;
      #  };
      editors = { neovim.enable = true; };
      #  graphics = {
      #    gimp.enable = true;
      #    imv.enable = true;
      #    inkscape.enable = true;
      #  };
      #  networking = { discord.enable = true; };
      #  utility = {
      #    bitwarden.enable = true;
      #    printers.enable = true;
      #    zathura.enable = true;
      #  };
      video = {
        #    handbrake.enable = true;
        mpv = {
          enable = true;
          #      hardware-acceleration = true;
        };
      };
      #  window-managers = { eww.enable = true; };
    };
    dev = {
      #insomnia.enable = true;
      git.enable = true;
    };
    shell = {
      #  alacritty.enable = false;
      #  bat.enable = true;
      direnv.enable = true;
      #  foot.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
  };

  home.packages = with pkgs; [ jq unrar ];
}
