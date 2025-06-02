{ pkgs, lib, inputs, config, ... }:

with lib;
let
  cfg = config.modules.waybar;
  adthand = inputs.adthand.packages.${pkgs.stdenv.system}.default;

in
{
  options.modules.waybar = { enable = mkEnableOption "waybar"; };
  config = mkIf cfg.enable {
    home.packages = [ adthand ];
    programs.waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; });
    };
    home.file.".config/waybar/config".source = ./config;
    home.file.".config/waybar/style.css".source = ./style.css;
  };
}
