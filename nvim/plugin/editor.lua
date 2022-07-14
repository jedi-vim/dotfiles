-- Configurações gerais
opt = vim.o
opt.number = true
opt.autoindent = true
opt.incsearch = true
opt.hlsearch = false
opt.wildmenu = true
opt.wildignore='*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'
opt.confirm = true
opt.title = true
opt.cursorline = true
opt.ignorecase = true
opt.updatetime= 100
opt.hidden = true
opt.splitbelow = true
opt.splitright = true

-- Indentation default
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.foldlevel=5
--
-- Manter CWD com o arquivo aberto
vim.cmd [[
autocmd BufEnter * silent! :lcd%:p:h
]]

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
 vim.cmd [[
   augroup YankHighlight
       autocmd!
           autocmd TextYankPost * silent! lua vim.highlight.on_yank()
             augroup end
 ]]

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

--notify
vim.notify = require("notify")
