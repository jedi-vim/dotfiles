local opt = vim.opt_local
opt.autoindent = true
opt.cindent = true
opt.cinwords = "if,elif,else,for,while,try,except,finally,def,class,with,match,case,async"
opt.colorcolumn = "80"
opt.copyindent = true
opt.expandtab = true
opt.formatoptions = "jntcoqlr" -- Inclui "r" para comentários
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 8
opt.smartindent = true -- Melhora a indentação automática
opt.breakindent = true -- Mantém a indentação em quebras de linha
opt.textwidth = 79 -- Segue o padrão PEP 8

-- vim.api.nvim_create_autocmd("InsertCharPre", {
--   pattern = { "*.py" },
--   group = vim.api.nvim_create_augroup("py-fstring", { clear = true }),
--   callback = function(params)

--     if vim.v.char ~= "{" then
--       return
--     end

--     local node = vim.treesitter.get_node_at_cursor()
--     if not node then
--       return
--     end

--     if node:type() ~= "string" then
--       node = node:parent()
--     end

--     if not node or node:type() ~= "string" then
--       return
--     end

--     local row, col, _, _ = vim.treesitter.get_node_range(node)
--     local first_char = vim.api.nvim_buf_get_text(params.buf, row, col, row, col + 1, {})[1]
--     if first_char == "f" then
--       return
--     end

--     vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<esc>`'la")
--   end,
-- })
