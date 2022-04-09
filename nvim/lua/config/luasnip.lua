local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node

luasnip.config.setup {
  history = true,
  store_selection_keys = '<TAB>',
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged,InsertLeave',
}

luasnip.add_snippets(
    "python", {
        s("pdb" , {
            t("import pdb;pdb.set_trace()")
        })
    }
)

vim.cmd([[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]])

require("luasnip/loaders/from_vscode").lazy_load()
