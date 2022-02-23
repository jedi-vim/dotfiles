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

-- Manter CWD com o arquivo aberto
-- Manter cursor sempre no meio da tela
vim.cmd [[
autocmd BufEnter * silent! :lcd%:p:h
]]

vim.cmd [[
setlocal scrolloff=9999
]]

-- Manter sessão
vim.cmd [[
autocmd VimEnter * source ~/.session.vim
autocmd VimLeave * mksession! ~/.session.vim
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

-- Indentação arquivos python
vim.cmd [[
  augroup python_indent
   autocmd!
   autocmd BufReadPre,BufReadPost *.py setlocal foldmethod=indent foldnestmax=2
]]
-- Highlight on yank
 vim.cmd [[
   augroup YankHighlight
       autocmd!
           autocmd TextYankPost * silent! lua vim.highlight.on_yank()
             augroup end
 ]]

--Set statusbar
vim.g.lightline = {
  colorscheme = 'wombat',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

--Colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]
