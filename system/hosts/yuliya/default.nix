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
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "mem_sleep_default=deep" ];
  };

  networking.interfaces.enp0s25.useDHCP = true;
  services.logind.lidSwitch = "ignore";
  modules = {
    networking = {
      enable = true;
      hostname = "yuliya";
    };
    hardware = { printers = { enable = false; }; };
    services = {
      avahi.enable = true;
      ssh.enable = true;
    };
    virtualisation = { docker.enable = true; };
  };

  time.timeZone = "Europe/Paris";

  environment.systemPackages = with pkgs; [ vim git fzf ripgrep ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "yes";
    kbdInteractiveAuthentication = false;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = { ll = "ls -la"; };
  };

  system.stateVersion = "21.11";
}
