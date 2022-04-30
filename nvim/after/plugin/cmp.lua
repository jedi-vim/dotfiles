local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end

local compare = require("cmp.config.compare")
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
  },
  sources = {
      { name = "luasnip" },
      { name = "treesitter" },
      { name = "nvim_lsp" },
      { name = "tags" },
      { name = "buffer" },
      { name = 'cmdline' },
      { name = "path" },
      { name = "nvim_lua" },
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  sorting = {
    comparators = {
      compare.kind,
      compare.offset,
      compare.exact,
      compare.score,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  },
})
