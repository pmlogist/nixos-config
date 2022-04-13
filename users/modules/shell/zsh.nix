{ config, lib, options, pkgs, ... }:

let
  cfg = config.modules.shell.zsh;
  # https://github.com/NixOS/nixpkgs/issues/160876#issuecomment-1046370485
  starship = pkgs.callPackage ./../../packages/starship.nix {
    inherit (pkgs.darwin.apple_sdk.frameworks) Security Foundation Cocoa;
  };
  inherit (lib) mkIf mkOption types;
in {
  options.modules.shell.zsh = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [ ripgrep ];

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.starship = {
      package = starship;
      enable = true;
      enableZshIntegration = true;
      settings = {
        scan_timeout = 10;
        character = {
          success_symbol = "[➜](bold green)";
          vicmd_symbol = "[](bold green)";
          error_symbol = "[✖](bold red)";
        };
      };
    };

    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableAutosuggestions = true;
      defaultKeymap = "viins";
      autocd = true;
      dirHashes = {
        docs = "$HOME/Docs";
        dl = "$HOME/Downloads";
        music = "$HOME/Music";
        project = "$HOME/Workspace";
      };
      envExtra = ''
        setopt AUTO_CD              # Go to folder path without using cd.

        setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
        setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
        setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

        #setopt CORRECT              # Spelling correction
        setopt CDABLE_VARS          # Change directory to a path stored in a variable.
        setopt EXTENDED_GLOB        # Use extended globbing syntax.
        setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
        setopt SHARE_HISTORY             # Share history between all sessions.
        setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
        setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
        setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
        setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
        setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
        setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
        setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

        setopt AUTO_PUSHD           # Push the current directory visited on the stack.
        setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
        setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

        export PATH=$XDG_CACHE_HOME/npm-packages/bin:$PATH
        export NODE_PATH=$XDG_CACHE_HOME/npm-packages/lib/node_modules
      '';
      initExtra = ''
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
        export PATH=$GOBIN:$PATH
      '';
      shellAliases = {
        #ls = "ls --color=auto";
        ll = "ls -la";
        code =
          "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        save = 50000;
        size = 50000;
        ignoreDups = true;
      };
      sessionVariables = rec {
        KEYTIMEOUT = 1;
        EDITOR = "vim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;
        BROWSER = "firefox";
        PAGER = "less";
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "underline";
      };
      localVariables = {
        GOPATH = "$HOME/.go";
        GOBIN = "$GOPATH/bin";
        DIRENV_LOG_FORMAT = "";
      };
      plugins = [
        rec {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = name;
            rev = "0.8.0-alpha1-pre-redrawhook";
            sha256 = "1gv7cl4kyqyjgyn3i6dx9jr5qsvr7dx1vckwv5xg97h81hg884rn";
          };
        }
        rec {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = name;
            rev = "0.32.0";
            sha256 = "12l9wrx0aysyj62kgp5limglz0nq73w8c415wcshxnxmhyk6sw6d";
          };
        }
        rec {
          name = "zsh-history-substring-search";
          file = "zsh-history-substring-search.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = name;
            rev = "v1.0.2";
            sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
          };
        }
      ];
    };
  };
}
