local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local opts = { silent = true }

vim.keymap.set("n", "<leader>a", mark.add_file, opts)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, opts)

vim.keymap.set('n', '<C-n>', function() ui.nav_file(1) end, opts)
vim.keymap.set('n', '<C-t>', function() ui.nav_file(2) end, opts)
vim.keymap.set('n', '<C-h>', function() ui.nav_file(3) end, opts)
vim.keymap.set('n', '<C-s>', function() ui.nav_file(4) end, opts)

