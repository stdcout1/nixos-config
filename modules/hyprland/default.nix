{ inputs, pkgs, lib, config, ...}: 

with lib;

let cfg = config.modules.hyprland;

in { 
  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
  options.desktop = {enable = mkEnableOption "desktop"; }; #enable desktop mode for hyprland
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi-wayland swww wl-clipboard
    ];
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        extraConfig = builtins.readFile (if config.desktop.enable then ./hyprland_desktop.conf else ./hyprland.conf);
    };
    #home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
