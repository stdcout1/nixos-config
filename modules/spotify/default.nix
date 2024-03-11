{ pkgs, lib, config, inputs, ... }:
with lib;
let 
    cfg = config.modules.spotify;
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    gruvboxy = pkgs.fetchgit {
    	url = "https://github.com/shvedes/spicetify-gruvbox";
	rev = "c285458ca1a8b95cc590d82779ca4b86e815f04e";
	sha256 = "sha256-wO+9jg5oFIpOBG5LucJE0HVsKt7qrj1Awc3IzA6sMNg=";
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
