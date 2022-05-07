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

  system.activationScripts.postUserActivation.text = ''
    # Install homebrew if it isn't there 
    if [[ ! -d "/usr/local/Homebrew" ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };
    taps = [
      "homebrew/core"
      "homebrew/services"
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-drivers"
      "koekeishiya/formulae"
    ];
    brews = [ "koekeishiya/formulae/yabai" "koekeishiya/formulae/skhd" ];
    casks = [
      # dev
      "visual-studio-code"
      "docker"
      "iterm2"
      "font-iosevka"
      "font-iosevka-nerd-font"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "insomnia"
      "figma"
      "paw"
      "alfred"
      #networking
      "discord"
      # videos
      "mpv"
      "qlvideo"
      "handbrake"
      # others
      "hackintool"
      "firefox"
      "microsoft-edge"
      "altserver"
      # utils
      "transmission"
      "obinskit"
      "smoothscroll"
      "radio-silence"
      "steam"
      "epic-games"
      "the-unarchiver"
      "steelseries-engine"
      "intel-power-gadget"
      "virtualbox"
      "virtualbox-extension-pack"
      "visual-studio-code"
      "bartender"
      "parrallels"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs.zsh.enable = true; # default shell on catalina

  system.stateVersion = 4;
}
