{ pkgs, lib, config, ... }:

with lib;
let 
    cfg = config.modules.scripts;
    screenshot = pkgs.writeShellScriptBin "screenshot" ''${builtins.readFile ./screenshot}'';		
    tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''${builtins.readFile ./tmux-sessionizer}'';
    adthan = pkgs.writeScriptBin "adthanpy" ''${builtins.readFile ./adthan.py}'';

in {
    options.modules.scripts = { enable = mkEnableOption "scripts"; };
    config = mkIf cfg.enable {
	    home.packages = with pkgs; [ grim slurp screenshot tmux-sessionizer adthan ];
    };
}

