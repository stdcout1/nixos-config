{ pkgs, lib, config, inputs, ... }:
with lib;
let
  cfg = config.modules.spotify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  blackout = pkgs.fetchFromGitHub {
    owner = "spicetify";
    repo = "spicetify-themes";
    sparseCheckout = ["/Blackout"];
    rev = "82e14abb3c954dd00c6c918ace7619b6ff558712";
    hash = "sha256-UzOVEHIwTjttd2v07Gp5tXsiY/fE9dbmZjpbq2KUL5Y=";
  } + "/Blackout";
in
{
  options.modules.spotify = { enable = mkEnableOption "spotify"; };

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  config = mkIf cfg.enable {

    programs.spicetify =
      {
        enable = true;
        theme = {
          name = "blackout";
          src = blackout;
          appendName = false;
          injectCss = true;
          replaceColors = true;
          overwriteAssets = true;
          sidebarConfig = false;
        };
        colorScheme = "def";

        enabledExtensions = with spicePkgs.extensions; [
          fullAppDisplay
          shuffle # shuffle+ (special characters are sanitized out of ext names)
        ];

      };
  };
}
