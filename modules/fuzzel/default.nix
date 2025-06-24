{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.fuzzel;

in
{
  options.modules.fuzzel = { enable = mkEnableOption "fuzzel"; };
  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = getExe pkgs.foot;
          font = "JetBrainsMono Nerd Font:size=12";
          horizontal-pad = 20;
          vertical-pad = 20;
          inner-pad = 0;
        };
        border = {
          width = 2;
          radius = 6;
        };
        colors = {
          background = "000000ff";
          text = "dcdfe4ff";
          match = "61afefff";
          selection = "dcdfe4ff";
          selection-text = "000000ff";
          border = "5d677aff";
        };
      };
    };
  };
}

