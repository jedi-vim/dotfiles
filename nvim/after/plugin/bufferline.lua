local ok, bufferline = pcall(require, "bufferline")
if not ok then
    return
end

bufferline.setup({
    options = {
    -- mode = "tabs",
    -- separator_style = 'slant',
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
})

vim.keymap.set("n", "<Leader>L", "[[<Cmd>BufferLineMoveNext<CR>]]", {desc="Mover buffer para direita"})
vim.keymap.set("n", "<Leader>A", "[[<Cmd>BufferLineMovePrev<CR>]]", {desc="Mover buffer para esquerda"})
