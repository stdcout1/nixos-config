{ inputs, pkgs, lib, config, ... }:

with lib;


let
  cfg = config.modules.niri;
in
{
  imports = [
      inputs.niri.homeModules.niri
  ];
  options.modules.niri = { enable = mkEnableOption "niri"; };
  # options.desktop = { enable = mkEnableOption "desktop"; }; #enable desktop mode for niri
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
    ];
    programs.niri = {
      enable = true;
    };
  };
}

