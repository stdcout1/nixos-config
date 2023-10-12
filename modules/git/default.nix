{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.git;
in
{
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
    programs.git = {
      enable = true;
      userName = "nasir";
      userEmail = "nasirkhimani@gmail.com";
      extraConfig = {
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
      };
    };
  };
}
