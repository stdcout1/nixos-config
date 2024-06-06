local lsp = require('lsp-zero').preset(
    {
        float_border = 'rounded',
        call_servers = 'global',
        configure_diagnostics = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = {
            preserve_mappings = false,
            omit = {},
        },
        manage_nvim_cmp = {
            set_sources = 'recommended',
            set_basic_mappings = true,
            set_extra_mappings = true,
            use_luasnip = true,
            set_format = true,
            documentation_window = true,
        },
    }
)

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup_servers({
    'lua_ls',
    'nil_ls',
    'pyright',
    'clangd',
    'tsserver',
    'elmls',
    'elixirls',
})

require("lspconfig").nil_ls.setup({
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        }
    }
})
require("lspconfig").elixirls.setup({
    cmd = {"elixir-ls"}
})
lsp.skip_server_setup({ 'rust_analyzer' })
lsp.setup()
local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "crates" },
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
        }),
    },
    experimental = {
        ghost_text = true,
    },
})

local rust_tools = require('rust-tools')
rust_tools.setup({
    server = {
        on_attach = function(_, bufnr)
            rust_tools.inlay_hints.set()
            vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set('n', '<leader>a', rust_tools.code_action_group.code_action_group, { buffer = bufnr })
        end
    }
})
