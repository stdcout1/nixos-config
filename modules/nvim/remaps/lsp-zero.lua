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
cmp.setup({
    sources = {
        { name = "path" },
        { name = "buffer" },
        { name = "crates" },
        { name = "copilot" },
        { name = "nvim_lsp" },
    },
    mapping = {
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
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
