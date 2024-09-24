{ inputs, pkgs, lib, config, ... }:

with lib;

let
  cfg = config.modules.jetbrains.idea-ultimate;
in
{
  options.modules.jetbrains.idea-ultimate = { enable = mkEnableOption "idea-ultimate"; };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains.idea-ultimate ];
  };
}

