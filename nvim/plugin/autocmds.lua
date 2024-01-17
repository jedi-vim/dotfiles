local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Manter CWD com o arquivo aberto
-- vim.cmd [[
-- autocmd BufEnter * silent! :lcd%:p:h
-- ]]

-- Manter cursor sempre no meio da tela
vim.cmd [[
augroup VCenterCursor
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.*
            \ let &scrolloff=winheight(win_getid())/2
augroup END
]]

-- Ajuste cursor em buffers
vim.cmd [[
augroup CursorLine
    autocmd!
    hi CursorLine term=bold cterm=bold guibg=Grey30
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
]]

-- sistema de numeração na transição de buffers
vim.cmd [[
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]]

-- Highlight on yank
autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})
