{ pkgs, lib, config, ... }:

with lib;
let 
    cfg = config.modules.scripts;
    screenshot = pkgs.writeShellScriptBin "screenshot" ''${builtins.readFile ./screenshot}'';		

in {
    options.modules.scripts = { enable = mkEnableOption "scripts"; };
    config = mkIf cfg.enable {
	    home.packages = with pkgs; [ grim slurp screenshot ];
    };
}

