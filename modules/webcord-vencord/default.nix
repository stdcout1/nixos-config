{ pkgs, lib, config, inputs, ... }:
with lib;
let cfg = config.modules.webcord-vencord;
in {
    options.modules.webcord-vencord = { enable = mkEnableOption "webcord-vencord"; };

    config = mkIf cfg.enable {
    	home.packages = [
            pkgs.vesktop
	];
	

    };
}

