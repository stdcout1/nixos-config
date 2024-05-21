{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xdg;

in {
  options.modules.xdg = { enable = mkEnableOption "xdg"; };
  config = mkIf cfg.enable {
    xdg.portal.config.common.default = "*";
    xdg.userDirs = {
      enable = true;
      documents = "$HOME/stuff/documents/";
      download = "$HOME/stuff/downloads/";
      videos = "$HOME/stuff/other/";
      music = "$HOME/stuff/other/";
      pictures = "$HOME/stuff/pictures/";
      desktop = "$HOME/stuff/other/";
      publicShare = "$HOME/stuff/other/";
      templates = "$HOME/stuff/other/";
    };
  };
}
