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

-- store listed buffers in tab local var
vim.t.bufs = vim.api.nvim_list_bufs()
local listed_bufs = {}
for _, val in ipairs(vim.t.bufs) do
  if vim.bo[val].buflisted then
    table.insert(listed_bufs, val)
  end
end
vim.t.bufs = listed_bufs

local bufferline_group = augroup("bufferline", { clear = true })

autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
  group = bufferline_group,
  callback = function(args)
    local utils = require "utils"
    if not vim.t.bufs then vim.t.bufs = {} end
    if not utils.is_buf_valid(args.buf) then return end
    if args.buf ~= utils.current_buf then
      utils.last_buf = utils.is_buf_valid(utils.current_buf) and utils.current_buf or nil
      utils.current_buf = args.buf
    end
    local bufs = vim.t.bufs
    if not vim.tbl_contains(bufs, args.buf) then
      table.insert(bufs, args.buf)
      vim.t.bufs = bufs
    end
    vim.t.bufs = vim.tbl_filter(utils.is_buf_valid, vim.t.bufs)
  end,
})

autocmd({ "BufDelete" }, {
  group = bufferline_group,
  callback = function(args)
    local removed
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            removed = true
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
    vim.t.bufs = vim.tbl_filter(require("utils").is_buf_valid, vim.t.bufs)
    vim.cmd.redrawtabline()
  end,
})
