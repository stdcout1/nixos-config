{ inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.firefox;

in {
    options.modules.firefox = { enable = mkEnableOption "firefox"; };

    config = mkIf cfg.enable {
        programs.firefox = {
            enable = true;    

            # Privacy about:config settings
            profiles.default = {

                isDefault = true;
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                  ublock-origin
                  gruvbox-dark-theme
                  darkreader
                ];
                # userChome.css to make it look better
                userChrome = ''
		:root {
    		    --tab-border-radius: 0 !important;
    		    --tab-block-margin: 0 !important;
		}

		:root[uidensity="compact"] {
		    --tab-min-height: 20px !important;
		    --tab-border-radius: 0 !important;
		    --tab-block-margin: 0 !important;
		}
		
		#tabbrowser-tabs:not([secondarytext-unsupported]) .tab-label-container {
		    height: initial !important; 
		}
		    '';
            };
        };
    };
}
