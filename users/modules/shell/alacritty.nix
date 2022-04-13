{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.shell.alacritty;
in
{
  options.modules.shell.alacritty = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = { enable = true; };

    xdg.configFile."alacritty/alacritty.yml".text = ''
      font:
        normal:
          family: JetBrains Mono Nerd Font
          # The `style` can be specified to pick a specific face.
          style: Regular

        # Bold font face
        bold:
          family: JetBrains Mono Nerd Font
          # The `style` can be specified to pick a specific face.
          style: Bold

        # Italic font face
        italic:
          family: JetBrains Mono Nerd Font
          # The `style` can be specified to pick a specific face.
          style: Italic

        # Point size of the font
        size: 10.0

        # Offset is the extra space around each character. `offset.y` can be thought of
        # as modifying the line spacing, and `offset.x` as modifying the letter spacing.
        offset:
          x: 0
          y: 0

        # Glyph offset determines the locations of the glyphs within their cells with
        # the default being at the bottom. Increasing `x` moves the glyph to the right,
        # increasing `y` moves the glyph upwards.
        glyph_offset:
          x: 0
          y: 0
    '';
  };
}
