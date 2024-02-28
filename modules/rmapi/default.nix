{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.rmapi;
in {
  options.modules.rmapi = { enable = mkEnableOption "rmapi"; };

  config = mkIf cfg.enable {
      home.packages = with pkgs; [ rmapi ];
  };
}
