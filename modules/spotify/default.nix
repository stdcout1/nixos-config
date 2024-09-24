{ pkgs, lib, config, inputs, ... }:
with lib;
let
  cfg = config.modules.spotify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  gruvboxy = pkgs.fetchgit {
    url = "https://github.com/Skaytacium/Gruvify";
    rev = "24c03816d4954eacd082df93c9a86cfcc54a431b";
    sha256 = "sha256-ShRdaXE504OhA4m7HiUXlXSbCZj/Hcalgal+NQ6kZb8=";
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
        colorScheme = "dark";

        enabledExtensions = with spicePkgs.extensions; [
          fullAppDisplay
          shuffle # shuffle+ (special characters are sanitized out of ext names)
        ];

      };
  };
}
