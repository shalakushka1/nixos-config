{ config, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      audio.enable_sounds = true;

      backdrop.enabled = true;

      bar.default = {
        background_opacity = 0.8;
        end = [ "group:g2" ];
        margin_edge = 4;
        margin_ends = 4;
        padding = 8;
        radius = 8;
        start = [
          "launcher"
          "workspaces"
          "media"
        ];
        thickness = 30;
        widget_spacing = 8;

        capsule_group = [
          {
            fill = "surface_variant";
            id = "g1";
            members = [
              "tray"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "brightness"
            ];
            opacity = 1.0;
            padding = 6.0;
          }

          {
            fill = "surface_variant";
            id = "g2";
            members = [
              "tray"
              "notifications"
              "network"
              "bluetooth"
              "volume"
              "brightness"
            ];
            opacity = 1.0;
            padding = 6.0;
            radius = 8.0;
          }
        ];
      };

      calendar = {
        enabled = true;

        account.personal_google = {
          type = "google";
        };
      };

      control_center.shortcuts = [
        { type = "wifi"; }
        { type = "bluetooth"; }
        { type = "caffeine"; }
        { type = "nightlight"; }
        { type = "clipboard"; }
        { type = "power_profile"; }
      ];

      dock = {
        magnification = false;
        reserve_space = false;
        shadow = false;
        show_instance_count = false;
        show_running = false;
      };

      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];

        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600;
          };

          "screen-off" = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };

          "lock-and-suspend" = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 900;
          };
        };
      };

      location.address = "Fortaleza, America";

      nightlight = {
        enabled = true;
        temperature_night = 5500;
      };

      notification = {
        background_opacity = 0.8;
        offset_x = 4;
        offset_y = 4;
      };

      osd = {
        background_opacity = 0.8;
        offset_x = 4;
        offset_y = 4;
      };

      plugins.enabled = [ ];

      shell = {
        avatar_path = "${config.home.homeDirectory}/.face";
        niri_overview_type_to_launch_enabled = true;
        polkit_agent = true;

        panel = {
          control_center_placement = "floating";
          floating_offset = 4;
          open_near_click_control_center = true;
          session_placement = "floating";
          session_position = "center";
          transparency_mode = "soft";
          wallpaper_placement = "floating";
        };

        screenshot.directory =
          "${config.home.homeDirectory}/Imagens/Captura de Tela";
      };

      theme = {
        community_palette = "Oxocarbon";
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "m3-tonal-spot";

        templates = {
          builtin_ids = [
            "alacritty"
            "btop"
            "gtk3"
            "gtk4"
            "niri"
            "qt"
          ];

          community_ids = [
            "pywalfox"
            "neovim"
            "papirus-icons"
            "steam"
          ];
        };
      };

      wallpaper = {
        directory = "${config.home.homeDirectory}/Imagens/Papeis de Parede";

        default.path =
          "${config.home.homeDirectory}/Imagens/Papeis de Parede/wallhaven_6qoodl.jpg";

        last.path =
          "${config.home.homeDirectory}/Imagens/Papeis de Parede/wallhaven_6qoodl.jpg";

        monitors = {
          LVDS-1.path =
            "${config.home.homeDirectory}/Imagens/Papeis de Parede/wallhaven_6qoodl.jpg";

          VGA-1.path =
            "${config.home.homeDirectory}/Imagens/Papeis de Parede/wallhaven_6qoodl.jpg";
        };
      };

      widget = {
        bluetooth.hide_when_no_connected_device = true;

        brightness.show_label = false;

        clock = {
          capsule = true;
          capsule_radius = 8;
          format = " {:%A, %d de %B de %Y | %H:%M} ";
          scale = 0.9;
        };

        launcher = {
          glyph = "niri";
          scale = 1.0;
        };

        media = {
          capsule = true;
          capsule_radius = 8;
          hide_when_no_media = true;
          scale = 0.9;
          title_scroll = "always";
        };

        network.show_label = false;
        notifications.hide_when_no_unread = true;
        volume.show_label = false;

        wallhaven.type = "noctalia/wallhaven:wallhaven";
        wallhaven_2.type = "noctalia/wallhaven:wallhaven";

        workspaces = {
          hide_when_empty = true;
          pill_scale = 0.9;
        };
      };
    };
  };
}
