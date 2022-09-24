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
opt.termguicolors = true
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

local api = vim.api
api.nvim_create_autocmd({'BufEnter', "BufAdd", "BufNew", "BufNewFile", "BufWinEnter"},
    {
        group = api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
        callback= function ()
            opt.foldmethod = "expr"
            opt.foldexpr = "nvim_treesitter#foldexpr()"
        end
    }
)

--notify
vim.notify = require("notify")
