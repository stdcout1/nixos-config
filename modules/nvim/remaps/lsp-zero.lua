local lsp = require('lsp-zero').preset("recommended")

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)
lsp.setup_servers({ 'lua_ls', 'nil_ls', 'pyright' })
lsp.skip_server_setup({ 'rust_analyzer' })
-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "crates" },
        { name = "copilot" },
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            -- documentation says this is important.
            -- I don't know why.
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
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
            vim.keymap.set('n', '<leader>a', rust_tools.code_action_group.code_action_group, { buffer = bufnr })
        end
    }
})
