{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.modules.services.yabai;
in
{
  options.modules.services.yabai = {
    enable = mkOption {
      type = types.bool;
      example = true;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    modules.services.skhd.enable = true;

    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = false;
      config = {
        mouse_follows_focus = "off";
        focus_follows_mouse = "off";
        window_placement = "second_child ";
        window_topmost = "off ";
        window_shadow = "on ";
        window_opacity = "off";
        window_opacity_duration = "0";
        active_window_opacity = "1 ";
        normal_window_opacity = "1 ";
        window_border = "off ";
        window_border_width = 4;
        split_ratio = "0.50";
        auto_balance = "off";
        mouse_modifier = "ctrl";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";

        layout = "bsp ";
        top_padding = 40;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 5;
      };
      extraConfig = ''
        # Apps
	sudo yabai --load-sa
	yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

        yabai -m rule --add app="^(AdGuard)$" manage=off;
        yabai -m rule --add app="^(Adobe Photoshop 2020)$" opacity=1.0;
        yabai -m rule --add app="^(Adobe Photoshop 2021)$" opacity=1.0;
        yabai -m rule --add app="^(Adobe Lighroom Classic)$" opacity=1.0;
        yabai -m rule --add app="^(Activity Monitor)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(App Store)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Archive Utility)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Bartender 3)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(BetterTouchTool)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Bitwarden)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Cascadea)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Calculator)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Calendar)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(CleanMyMac X)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Chromium)$" opacity=1.0
        yabai -m rule --add app="^(ColorWell)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(DeSmuME)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Discord)$" opacity=1.0;
        yabai -m rule --add app="^(Discord)$" title="Discord Updater" manage=off;
        yabai -m rule --add app="^(Disk Utility)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Docker Desktop)$" manage=off;
        yabai -m rule --add app="^(EPSON XP-540 Series)$" manage=off;
        yabai -m rule --add app="^(Finder)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Figma)$" opacity=1.0;
        yabai -m rule --add app="^Firefox$" opacity=1.0;
        yabai -m rule --add app="^Firefox$" title="Opening.+" manage=off
        yabai -m rule --add app="^(Font Book)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Flume)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Grids)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Hackintool)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(HandBrake)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Insomnia)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Karabiner-Elements)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Installer*)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Logic Pro)$" opacity=1.0;
        yabai -m rule --add app="^(Mail)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Maps)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Messages)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Microsoft Edge)$" opacity=1.0;
        yabai -m rule --add app="^(mGBA)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(MTGA)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(mpv)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Notes)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Music)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(ObinsKit)$" manage=off opacity=1.0
        yabai -m rule --add app="^(Paw)$" manage=off opacity=1.0
        yabai -m rule --add app="^(Pixelmator Pro)$" manage=off opacity=1.0
        yabai -m rule --add app="^(Photos)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Polarr Photo Editor)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Preview)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Postico)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(QuickTime Player)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Radio Silence)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Reminders)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Spotify)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(System Information)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(System Preferences)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Streamlink Twitch GUI)$" opacity=1.0;
        yabai -m rule --add app="^(TablePlus)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(TextEdit)$" manage=off;
        yabai -m rule --add app="^(Voice Memos)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(The Unarchiver)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Transmission)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(VK Messenger)$" manage=off opacity=1.0;
        yabai -m rule --add app="^(Yandex)$" opacity=1.0;
      '';
    };
  };
}
