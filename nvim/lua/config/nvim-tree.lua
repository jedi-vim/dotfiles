require'nvim-tree'.setup({
    view = {
        relativenumber = true,
        number = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    }
})

-- local keymap = vim.api.nvim_set_keymap
-- keymap( "n", "<F9>", ":NvimTreeToggle<CR>", { noremap = true })
