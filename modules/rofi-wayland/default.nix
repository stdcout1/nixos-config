{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.rofi-wayland;
  rofi-power-menu = pkgs.writeShellScriptBin "rofi-power-menu" ''${builtins.readFile ./power.sh}'';
in
{
  options.modules.rofi-wayland = { enable = mkEnableOption "rofi-wayland"; };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.rofi-wayland rofi-power-menu ];

    home.file.".config/rofi/config.rasi".text = builtins.readFile ./config.rasi;

  };
}
