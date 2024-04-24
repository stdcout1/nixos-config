{ inputs, pkgs, lib, config, ...}: 

with lib;

let
    cfg = config.modules.hyprlock;
in { 
  options.modules.hyprlock = { enable = mkEnableOption "hyprlock"; };
  config = mkIf cfg.enable {
      home.packages = [pkgs.hyprlock];
      home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  };
}

