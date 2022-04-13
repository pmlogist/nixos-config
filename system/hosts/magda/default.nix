{ inputs, config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot = {
    initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-uuid/7cdb042e-1d93-4a91-a439-af8fdb2f7e8d";
      preLVM = true;
      allowDiscards = true;
    };
    kernelParams = [ "mem_sleep_default=deep" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        gfxmodeEfi = "1024x768";
      };
    };
  };

  environment.systemPackages = with pkgs; [ vim git ];

  services.fwupd.enable = true;
  services.fprintd.enable = true;

  modules = {
    desktop = { gnome.enable = true; };
    networking = {
      enable = true;
      hostname = "magda";
      interfaces.enp0s31f6 = true;
    };
    hardware = {
      audio.enable = true;
      # Needs a fix https://github.com/NixOS/nixpkgs/issues/167971
      printers = { enable = true; };
    };
    devices = { ios.enable = true; };
    services = {
      #  avahi.enable = true;
      #  gvfs.enable = true;
      #  polkit.enable = true;
      ssh.enable = true;
    };
    virtualisation = { docker.enable = true; };
  };

  #services.udev.packages = [
  #  (pkgs.writeTextFile {
  #    name = "obinslab_udev";
  #    text = ''
  #      SUBSYSTEM=="input", GROUP="input", MODE="0666"

  #      # For ANNE PRO 2
  #      SUBSYSTEM=="usb", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8008", MODE="0666", GROUP="plugdev"
  #      KERNEL=="hidraw*", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8008", MODE="0666", GROUP="plugdev"
  #      SUBSYSTEM=="usb", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8009", MODE="0666", GROUP="plugdev"
  #      KERNEL=="hidraw*", ATTRS{idVendor}=="04d9", ATTRS{idProduct}=="8009", MODE="0666", GROUP="plugdev"
  #    '';
  #    destination = "/etc/udev/rules.d/obinslab.rules";
  #  })
  #];

  time.timeZone = "Europe/Paris";

  system.stateVersion = "21.11";
}
