-- Configurações gerais
local opt = vim.opt
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
opt.termguicolors = true
-- opt.clipboard:append("unnamedplus")
opt.showmatch = true

-- Indentation default
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.foldlevel=5

opt.signcolumn = "yes"
