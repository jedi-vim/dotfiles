local ok, catppuccin =  pcall(require, 'catppuccin')
if not ok then
    return
end

catppuccin.setup{
    term_colors=true
}

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.cmd[[colorscheme catppuccin]]
