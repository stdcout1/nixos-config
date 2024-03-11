{ inputs, pkgs, lib, config, ...}: 

with lib;

let cfg = config.modules.hyprland;

in { 
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi-wayland swww wl-clipboard
    ];
    wayland.windowManager.hyprland = {
	enable = true;
	systemd.enable = true;
	extraConfig = builtins.readFile ./hyprland.conf;
    };
    #home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
