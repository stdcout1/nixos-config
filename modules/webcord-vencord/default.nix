{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.webcord-vencord;
in {
    options.modules.webcord-vencord = { enable = mkEnableOption "webcord-vencord"; };

    config = mkIf cfg.enable {
    	home.packages = [
	    pkgs.webcord-vencord
	];
	
	home.file.".config/WebCord/Themes/gruvbox".source = ./gruvbox;
	home.file.".config/WebCord/config.json".source = ./config.json;

    };
}

