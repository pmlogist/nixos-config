{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  #system.activationScripts.postUserActivation.text = ''
  #    # Install homebrew if it isn't there 
  #    if [[ ! -d "/usr/local/Homebrew" ]]; then
  #      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  #    fi
  #  '';
  homebrew = {
    #brewPrefix = "/opt/homebrew/bin";
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };
    taps = [
      "homebrew/core"
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-drivers"
    ];
    casks = [
      "radio-silence"
      "bitwarden"
      "discord"
      "iterm2"
      "obinskit"
      "mpv"
      "insomnia"
      ## "kitty"
      # Font support is better with homebrew
      "font-jetbrains-mono-nerd-font"
    ];
    # REMOVED: brew "xorpse/formulae/yabai", args: ["HEAD"]
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ pkgs.vim ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  modules = {
    services = {
      skhd.enable = true;
      #yabai.enable = true;
    };
  };
}
