{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.git;
in
{
  options.modules.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      # ...
      extraConfig = {
        credential = {
          credentialStore = "secretservice";
          helper = "${pkgs.nur.repos.utybo.git-credential-manager}/bin/git-credential-manager-core";
        };
      };
    };
  };
}

