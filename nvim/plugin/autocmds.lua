local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Manter CWD com o arquivo aberto
-- vim.cmd [[
-- autocmd BufEnter * silent! :lcd%:p:h
-- ]]

-- Manter cursor sempre no meio da tela
autocmd({ "BufEnter", "WinEnter", "WinNew", "VimResized" }, {
  group = augroup("VCenterCursor", { clear = true }),
  callback = function()
    local winid = vim.api.nvim_get_current_win()
    local height = vim.api.nvim_win_get_height(winid)
    vim.opt.scrolloff = math.floor(height / 2)
  end,
})

-- Ajuste cursor em buffers
local cursorlinegroup = augroup("CursorLine", { clear = true })
autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorlinegroup ,
  callback = function()
    vim.opt.cursorline = true
  end,
})

autocmd({ "WinLeave" }, {
  group = cursorlinegroup,
  callback = function()
    vim.opt.cursorline = false
  end,
})

-- sistema de numeração na transição de buffers
local numbertooglegroup = augroup("NumberToogle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numbertooglegroup,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = numbertooglegroup,
  callback = function()
    vim.opt.relativenumber = false
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

-- Sign Column activate
autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    vim.opt.signcolumn = "yes"
  end
})
