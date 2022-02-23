require'nvim-tree'.setup()

local keymap = vim.api.nvim_set_keymap
keymap( "n", "<F9>", ":NvimTreeToggle<CR>", { noremap = true })
