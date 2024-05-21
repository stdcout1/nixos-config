{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.nvim;
  nvim-lsp-zero = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lsp-zero";
    src = pkgs.fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "lsp-zero.nvim";
      rev = "0d79f282566a95b0d6b2f1aab9ada54c3de0f92e"; #branch 2.X ... need to update manually 
      sha256 = "sha256-SvshWzbgLsY2+l32R6+zkXurlIqUeMbKNUzI5B1ygIA=";
    };
  };
in
{
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {

    home.file.".config/nvim/settings.lua".source = ./init.lua;
    # plugin specific lua config
    home.file.".config/nvim/remaps" = {
      source = ./remaps;
      recursive = true;
    };
    home.packages = with pkgs; [
      nil
      nixpkgs-fmt # Nix
      lua-language-server
      stylua # Lua
      rustc
      cargo
      rust-analyzer
      gcc
      rustfmt # Rust and gcc
      ripgrep
      unzip # for lsp-zero
      python39
      pyright #python
      clang-tools #c and cpp
      nodePackages.typescript-language-server
      nodejs #web dev
      elmPackages.elm-language-server #elm
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-live
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        #dependencies
        plenary-nvim
        nvim-lspconfig
        cmp-nvim-lsp
        rust-tools-nvim
        crates-nvim
        vim-be-good
        markdown-preview-nvim
        {
          plugin = gruvbox;
          config = "colorscheme gruvbox";
        }
        {
          plugin = impatient-nvim;
          config = "lua require('impatient')";
        }
        {
          plugin = lualine-nvim;
          config = "lua require('lualine').setup()";
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile (./remaps/telescope.lua);
        }

        {
          plugin = indent-blankline-nvim;
          config = "lua require('ibl').setup()";
        }
        {
          plugin = comment-nvim;
          config = "lua require('Comment').setup()";
        }
        cmp-path
        cmp-buffer
        nvim-cmp
        luasnip
        cmp_luasnip
        friendly-snippets #sources for nvim-cmp
        {
          plugin = nvim-lsp-zero;
          type = "lua";
          config = builtins.readFile (./remaps/lsp-zero.lua);
        }
        {
          plugin = nvim-treesitter.withPlugins (p: [ p.rust p.python p.nix p.comment p.toml p.lua p.json p.yaml p.nix p.c p.cpp p.javascript p.typescript p.elm ]);
          type = "lua";
          config = builtins.readFile (./remaps/treesitter.lua);
        }
        {
          plugin = crates-nvim;
          type = "lua";
          config = builtins.readFile (./remaps/crates.lua);
        }
        {
          plugin = copilot-lua;
          type = "lua";
          config = builtins.readFile (./remaps/copilot.lua);
        }
        {
          plugin = nvim-surround;
          type = "lua";
          config = "require('nvim-surround').setup({})";
        }
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = "require('nvim-autopairs').setup {}";
        }
        {
          plugin = hop-nvim;
          type = "lua";
          config = builtins.readFile (./remaps/hop.lua);
        }
        {
          plugin = harpoon;
          type = "lua";
          config = builtins.readFile (./remaps/harpoon.lua);
        }
        {
          plugin = undotree;
          type = "lua";
          config = builtins.readFile (./remaps/undotree.lua);
        }
        {
          plugin = vim-fugitive;
          type = "lua";
          config = builtins.readFile (./remaps/vim-fugitive.lua);
        }
      ];

      extraConfig = ''
        luafile ~/.config/nvim/settings.lua
      '';
    };
  };
}

