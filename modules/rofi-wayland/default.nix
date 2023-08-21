{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.rofi-wayland;
in {
    options.modules.rofi-wayland = {enable = mkEnableOption "rofi-wayland";};
    config = mkIf cfg.enable {

    	home.file.".config/rofi/config.rasi".text = ''@theme "${pkgs.rofi-wayland}/share/rofi/themes/gruvbox-dark-hard.rasi"'';

    };
}
