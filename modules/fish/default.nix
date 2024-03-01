{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.fish;
in {
  options.modules.fish = { enable = mkEnableOption "fish"; };

  config = mkIf cfg.enable {
    modules.starship.enable = true;

      home.packages = with pkgs; [
        bat
        exa
        fd
        fzf
        fish
      ];
      programs.fish = {
        enable = true;
        plugins = [
          {
            name = "autopairs";
            src = pkgs.fetchFromGitHub {
              owner = "jorgebucaran";
              repo = "autopair.fish";
              rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
              sha256 = "qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
            };
          }
          {
            name = "fzf";
            src = pkgs.fetchFromGitHub {
              owner = "patrickF1";
              repo = "fzf.fish";
              rev = "v9.3";
              sha256 = "1Rx17Y/NgPQR4ibMnsZ/1UCnNbkx6vZz43IKfESxcCA=";
            };
          }
          {
            name = "puffer-fish";
            src = pkgs.fetchFromGitHub {
              owner = "nickeb96";
              repo = "puffer-fish";
              rev = "41721259f16b9695d582a8de8d656d4e429d7eea";
              sha256 = "TdGyrAlL7aMxNtemxzOwTaOI+bbQ4zML2N2tV300FM8=";
            };
          }
          {
            name = "abbreviation-tips";
            src = pkgs.fetchFromGitHub {
              owner = "gazorby";
              repo = "fish-abbreviation-tips";
              rev = "v0.6.0";
              sha256 = "fveTvR+T6IiX8Zk5m6zToo1OtZc1VyrCHfOG63e9b64=";
            };
          }
        ];

        functions = {
          mkcd = {
            body = "mkdir -p $argv; cd $argv";
            description = "mkdir and cd into it";
          }; 
        };

        shellAbbrs = {
          
          # nvim
          vi = "nvim";
          vim = "nvim";
          svi = "sudo nvim";
          svim = "sudo nvim";

        lsa = "exa -lag --git --icons --sort=type";
          l = "exa -lag --git --icons --sort=type";
          ll = "exa -l --git --icons --sort=type";
          la = "exa -lag --git --icons --sort=type";
          rw = "swww img $(ls $NIXOS_CONFIG_DIRpics | shuf -n 1)";


      };

      shellInit = ''
      # fish greeting
      set -g fish_greeting 

      # Env vars
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      '';

      interactiveShellInit = ''
      set fzf_preview_dir_cmd exa --all --color=always
      set fzf_fd_opts --hidden --exclude=.git --exclude=.github --exclude=.cache

      '';
    };
  };
}
