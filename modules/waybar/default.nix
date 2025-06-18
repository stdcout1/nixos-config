{ pkgs, lib, inputs, config, ... }:

with lib;
let
  cfg = config.modules.waybar;
  adthand = inputs.adthand.packages.${pkgs.stdenv.system}.default;

in
{
  options.modules.waybar = { enable = mkEnableOption "waybar"; };
  config = mkIf cfg.enable {
    home.packages = [ adthand ];
    programs.waybar = {
      enable = true;
      settings = {
        mainbar = {
          layer = "top";
          margin-bottom = -2;
          position = "top";
          height = 26;
          output = [
            "eDP-1"
          ];

          modules-left = [ "custom/logo" "hyprland/workspaces" ];
          modules-right = [ "custom/adthand" "network" "clock" "pulseaudio" "battery" ];

          "custom/logo" = {
            format = "";
            tooltip = false;
            on-click = '''';
          };
          "custom/adthand" = {
            format = "{}";
            return-type = "json";
            tooltip = true;
            exec = "adthand waybar";
            interval = 60;
            max-length = 30;
          };
          "pulseaudio" = {
            format = "{volume}%";
            format-muted = "mute";
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };

          "hyprland/workspaces" = {
            on-click = "activate";
          };

          "clock" = {
            interval = 60;
            format = "{:%a %d/%m %I:%M}";
          };

          "battery" = {
            tooltip = false;
          };

          "network" = {
            format = "{essid}";
            format-disconnected = "Disconnected";
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          padding: 0;
          margin: 0;
          font-size: 11px;
        }

        window#waybar {
          background: #292828;
          color: #ffffff;
        }
  
        #custom-logo {
          font-size: 18px;
          margin: 0;
          margin-left: 7px;
          margin-right: 12px;
          padding: 0;
          font-family: JetBrainsMono Nerd Font Mono;
        }

        #custom-adthand {
            margin-right: 7px
        }
  
        #workspaces button {
          margin-right: 10px;
          color: #ffffff;
        }
        #workspaces button:hover, #workspaces button:active {
          background-color: #292828;
          color: #ffffff;
        }
        #workspaces button.active {
          background-color: #383737;
        }

        #network {
          margin-right: 7px;		
        }

        #battery {
          margin-left: 7px;
          margin-right: 3px;
          color: #ffffff
        }
        #battery.charging {
            color: #97cf8a
        }

        #pulseaudio {
            margin-left: 7px;
            color: #ffffff
        }

        #pulseaudio.bluetooth {
            color: #1c63cc
        }
      '';
    };
  };
}
