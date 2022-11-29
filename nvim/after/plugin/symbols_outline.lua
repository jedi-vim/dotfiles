local ok, symbols_outline = pcall(require, "symbols-outline")
if not ok then
    return
end
symbols_outline.setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false, -- experimental
    position = 'right',
    autoclose = true,
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a"
    }
})

vim.keymap.set("n", "<F6>", "[[ <Cmd>SymbolsOutline<CR> ]]", {})
