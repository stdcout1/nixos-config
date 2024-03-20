{ inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.steam;

in {
    options.modules.steam = { enable = mkEnableOption "steam"; };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            steam
            lutris # basically wanted with steam
        ];
    };
}


