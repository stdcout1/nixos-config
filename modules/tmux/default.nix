{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.tmux;
in {
  options.modules.tmux= { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
      programs.tmux = 
      {
        enable = true;
        prefix = "C-Space";
        keyMode = "vi";
        extraConfig = ''
        set -g mouse on
        '';
      };
    };
}
