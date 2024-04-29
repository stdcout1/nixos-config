{ inputs, pkgs, lib, config, ...}: 

with lib;

let
    cfg = config.modules.hypridle;
in { 
  options.modules.hypridle = { enable = mkEnableOption "hypridle"; };
  config = mkIf cfg.enable {
      home.packages = [pkgs.hypridle];
      home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
  };
}

