{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.desktop.gnome;
in
{
  options.modules.desktop.gnome = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome.gnome-terminal
      gnomeExtensions.appindicator
      gnomeExtensions.pop-shell
      gnomeExtensions.hide-activities-button
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.transparent-top-bar-adjustable-transparency
      gnomeExtensions.screenshot-directory
    ];
    services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

    environment.etc."xdg/user-dirs.defaults".text = ''
      DOWNLOAD=Downloads
      TEMPLATES=Templates
      PUBLICSHARE=Public
      DOCUMENTS=Docs
      MUSIC=Music
      PICTURES=Pics
      VIDEOS=Vids
    '';

    environment.gnome.excludePackages = with pkgs; [
      epiphany
      evince
      yelp
      gnome.cheese
      gnome-photos
      gnome.gnome-music
      gnome.gedit
      gnome.seahorse
      gnome.gnome-system-monitor
      gnome.gnome-characters
      gnome.gnome-weather
      gnome.gnome-disk-utility
      #gnome.totem
      gnome.tali
      gnome.hitori
      gnome.atomix
      gnome-tour
      gnome.geary
      gnome-connections
    ];
  };
}
