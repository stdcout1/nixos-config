{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.modules.bemenu;
in
{
  options.modules.bemenu = { enable = mkEnableOption "bemenu"; };
  config = mkIf cfg.enable {
    programs.bemenu = {
      enable = true;
      settings = {
        hp = 4;
        hf = "#ffffff";
        sf = "#ffffff";
        tf = "#ffffff";
      };
    };

  };
}

