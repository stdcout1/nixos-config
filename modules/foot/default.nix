{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.foot;

in
{
  options.modules.foot = { enable = mkEnableOption "foot"; };
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=11";
        };
        cursor.color = "dcdfe4 a3b3cc";
        colors = {
          # cursor = "dcdfe4";
          foreground = "dcdfe4";
          background = "000000"; # emo black

          regular0 = "282c34"; # dark grayish black
          regular1 = "e06c75"; # red
          regular2 = "98c379"; # green
          regular3 = "e5c07b"; # yellow
          regular4 = "61afef"; # blue
          regular5 = "c678dd"; # magenta
          regular6 = "56b6c2"; # cyan
          regular7 = "dcdfe4"; # white (light gray)

          bright0 = "5d677a"; # bright black (dim gray)
          bright1 = "e06c75";
          bright2 = "98c379";
          bright3 = "e5c07b";
          bright4 = "61afef";
          bright5 = "c678dd";
          bright6 = "56b6c2";
          bright7 = "dcdfe4";

          urls = "0087bd";

          selection-foreground = "000000";
          selection-background = "fffacd";
        };
      };
    };
  };
}
