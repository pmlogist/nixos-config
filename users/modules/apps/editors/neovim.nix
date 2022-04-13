{ config, lib, options, pkgs, ... }:

let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.apps.editors.neovim;

in {
  options.modules.apps.editors.neovim = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        lua << EOF
          require "main"
        EOF
      '';
      extraPackages = with pkgs;
        with vimPlugins;
        with nodePackages; [
          # Before adding nixpkgs needed ls
          nodejs-17_x
          wget
          # Language servers
          gopls
          pyright
          rnix-lsp
          sumneko-lua-language-server
          nodePackages.typescript-language-server
          # Formatters
          black
          nixfmt
          stylua
          # Needed dependencies 
          gcc
          ripgrep
          unzip
        ];
    };
  };
}
