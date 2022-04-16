{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.modules.shell.tmux;
in {
  options.modules.shell.tmux = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      prefix = "C-a";
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
            #set -g terminal-overrides ',xterm-256color:Tc'
            #set -g default-terminal "tmux-256color"
            set -as terminal-overrides ',xterm*:sitm=\E[3m'
          '';
        }
      ];
      extraConfig = ''
        set-option -g status-position top
        set -g mouse on
        set -s escape-time 0
      '';
    };
  };
}
