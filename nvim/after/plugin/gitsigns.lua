local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup {
    numhl = false,
    linehl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ['n ]g'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
      ['n [g'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

      ['n ghu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['n ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',

    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 0
    }
}
