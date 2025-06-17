{ pkgs, lib, config, inputs, ... }:
with lib;
let
  cfg = config.modules.spotify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  gruvboxy = pkgs.fetchgit {
    url = "https://github.com/Skaytacium/Gruvify";
    rev = "8590028db983bed7d3e93b48d46af58291929025";
    sha256 = "sha256-UCJWMLcxZ5dT7KZtVaDswtN3MFM+zFylibF+bDE2qiE=";
  };
in
{
  options.modules.spotify = { enable = mkEnableOption "spotify"; };

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

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
        colorScheme = "Gruvbox";

        enabledExtensions = with spicePkgs.extensions; [
          fullAppDisplay
          shuffle # shuffle+ (special characters are sanitized out of ext names)
        ];

      };
  };
}
