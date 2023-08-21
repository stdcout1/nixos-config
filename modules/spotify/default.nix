{ pkgs, lib, config, inputs, ... }:
with lib;
let 
    cfg = config.modules.spotify;
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    gruvboxy = pkgs.fetchgit {
    	url = "https://github.com/shvedes/Gruvboxy";
	rev = "c0faf4913e0070d62fb4a12ef7006a99302c3eb5";
	sha256 = "sha256-6WKRcSuJna4ipfaoqOHnEm6Hf/VJFcdHR0jD5lvhJgY=";
    };
in {
    options.modules.spotify = { enable = mkEnableOption "spotify"; };

    imports = [ inputs.spicetify-nix.homeManagerModule ];

    config = mkIf cfg.enable {

      programs.spicetify =   
    	{
      	    enable = true;
	    theme = {
	    	name = "Gruvboxy";
		src = gruvboxy;
		appendName = false;
		injectCss = true;
		replaceColors = true;
		overwriteAssets = false;
		sidebarConfig = false;
	    };
	    colorScheme = "dark";

	    enabledExtensions = with spicePkgs.extensions; [
        	fullAppDisplay
        	shuffle # shuffle+ (special characters are sanitized out of ext names)
      	    ];
	   
    	};
    };
}
