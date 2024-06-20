-- local disable_diagnostic = false
-- local helm_tags = {"{{-", ".Values"}
-- local bufnr = 0
-- local bufname = api.nvim_buf_get_name(bufnr)

-- if not string.match(bufname, '/?%.yaml') or not string.match(bufname, '/?%.yml') then
--   return
-- end

-- local buf_content_str = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
-- -- Usar regex aqui
-- for pattern in helm_tags do
--   if string.find(buf_content_str, pattern) then
--     disable_diagnostic = true
--     break
--  end
-- end

-- if disable_diagnostic then
--   vim.diagnostic.disable(bufnr)
--   vim.diagnostic.hide(nil, bufnr)
--   vim.diagnostic.reset(nil, bufnr)
-- end
