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
      device = "/dev/disk/by-uuid/df21471d-aa2e-4df5-81e5-a9c70d5db6c8";
      preLVM = true;
      allowDiscards = true;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [ vim gnumake git ];

  programs.zsh.enable = true;

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  services.fwupd.enable = true;

  modules = {
    networking = {
      enable = true;
      hostname = "profiterole";
      interfaces = { };
    };
    hardware = {
      audio.enable = true;
      graphics = {
        enable = true;
        amd.enable = true;
      };
      printers = { enable = true; };
    };
    devices = { ios.enable = true; };
    services = {
      polkit.enable = true;
      ssh.enable = true;
    };
    virtualisation = { docker.enable = true; };
  };

  time.timeZone = "Europe/Paris";

  system.stateVersion = "21.11";
}
