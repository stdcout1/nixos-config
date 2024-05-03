{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.hyprlock;
in
{
  imports = [ inputs.hyprlock.homeManagerModules.hyprlock ];
  options.modules.hyprlock = { enable = mkEnableOption "hyprlock"; };
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      backgrounds = [
        {
          path = ''~/flake/pics/rails.jpg'';
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      general = {
        disable_loading_bar = true;
      };

      input-fields = [
        {
          size.width = 250;
          size.height = 60;
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
          hide_input = false;
          position.x = 0;
          position.y = -120;
          halign = "center";
          valign = "center";
        }
      ];
      labels = [
        {
          text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 120;
          font_family = ''JetBrains Mono Nerd Font Mono ExtraBold'';
          position.x = 0;
          position.y = -300;
          halign = "center";
          valign = "top";
        }
        {
          text = ''Hi there, $USER'';
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 25;
          font_family = "JetBrains Mono Nerd Font Mono";
          position.x = 0;
          position.y = -40;
          halign = "center";
          valign = "center";
        }
        {
          text = ''In progress...'';
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 18;
          font_family = "JetBrainsMono";
          position.x = 0;
          position.y = 0;
          halign = "center";
          valign = "bottom";
        }
      ];


    };
  };
}

