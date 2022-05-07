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
      editors = { neovim.enable = true; };
      video = { mpv = { enable = true; }; };
    };
    dev = { git.enable = true; };
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
