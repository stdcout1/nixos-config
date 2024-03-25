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
          font = "JetBrainsMono Nerdfont:size=11:line-height=16px";
          pad = "12x12";
        };
        colors = {
          #gruvbox theme
          alpha = 0.8;
          foreground = "ebdbb2";
          background = "282828";

          regular0 = "282828";
          regular1 = "cc241d";
          regular2 = "98971a";
          regular3 = "d79921";
          regular4 = "458588";
          regular5 = "b16286";
          regular6 = "689d6a";
          regular7 = "a89984";

          bright0 = "928374";
          bright1 = "fb4934";
          bright2 = "b8bb26";
          bright3 = "fabd2f";
          bright4 = "83a598";
          bright5 = "d3869b";
          bright6 = "8ec07c";
          bright7 = "ebdbb2";
        };
      };
    };
  };
}
