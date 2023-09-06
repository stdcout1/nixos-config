{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.nvim;
  nvim-lsp-zero = pkgs.vimUtils.buildVimPluginFrom2Nix {
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
      rnix-lsp nixfmt # Nix
      lua-language-server stylua # Lua
      rustc cargo rust-analyzer gcc # Rust
      ripgrep
      unzip # for lsp-zero
      python39 pyright #python
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
        luasnip
        cmp-path cmp-buffer nvim-cmp #sources
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
          config = "lua require('telescope').setup()";
        }
        {
          plugin = indent-blankline-nvim;
          config = "lua require('indent_blankline').setup()";
        }
        {
          plugin = nvim-lsp-zero;
          config = ''
            lua << EOF
            local lsp = require('lsp-zero').preset("recommended")
            lsp.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp.default_keymaps({buffer = bufnr})
            end)
            lsp.setup_servers({'lua_ls', 'rnix', 'pyright'})
            lsp.skip_server_setup({'rust_analyzer'})
            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            lsp.setup()
            local cmp = require('cmp')
            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "buffer" },
                    { name = "nvim_lsp" },
                    { name = "crates" },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                }
            })
            local rust_tools = require('rust-tools')
            rust_tools.setup({
                server = {
                    on_attach = function(_, bufnr)
                        rust_tools.inlay_hints.set()
                        vim.keymap.set('n', '<leader>a', rust_tools.code_action_group.code_action_group, {buffer = bufnr})
                    end
                }
            })
            EOF
          '';
        }
        {
          plugin = nvim-treesitter;
          config = ''
            lua << EOF
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
            EOF
          '';
        }
      ];

      extraConfig = ''
        luafile ~/.config/nvim/settings.lua
      '';
    };
  };
}

