{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.dunst;

in {
    options.modules.dunst = { enable = mkEnableOption "dunst"; };
    config = mkIf cfg.enable {
	home.packages = with pkgs; [
	    dunst
	];

        services.dunst = {
            enable = true;
            settings = {
                global = {
                    origin = "top-right";
                    offset = "30x10";
		    width = 125;
		    height = 100;
                    separator_height = 2;
                    padding = 12;
                    horizontal_padding = 12;
                    text_icon_padding = 12;
                    frame_width = 4;
                    separator_color = "#d5c4a1";
                    idle_threshold = 120;
                    font = "JetBrainsMono Nerd font 7";
                    line_height = 0;
                    format = "<b>%s</b>\n%b";
                    alignment = "center";
                    icon_position = "off";
                    startup_notification = "false";
                    corner_radius = 12;

                    frame_color = "#d5c4a1";
                    background = "#504945";
                    foreground = "#d5c4a1";
                    timeout = 2;
                };
            };
        };
    };
}
