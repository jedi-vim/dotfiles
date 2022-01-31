local keymap = vim.api.nvim_set_keymap

-- LeaderKey
vim.g.mapleader = ","

--Salvar com C-s
keymap("n", "<C-s>", ":w<CR>", {noremap=false})

-- Edit init.vim
keymap("n", "<leader>ev", ":vsplit ~/.config/nvim/init.lua<cr>", {noremap = true})

-- Reload vim conf
keymap("n", "<leader>sv", ":source ~/.config/nvim/init.lua<cr>", {noremap = true})

-- Copiar para o clip board
keymap("v", "yy" , '"+y', {silent = true, noremap = true })

-- Atalho para mover blocos de texto
keymap("v", "J", ":m '>+1<CR>gv=gv", {noremap = true})
keymap("v", "K", ":m '<-2<CR>gv=gv", {noremap = true})

-- Mudar para proxima janela
keymap("n", "<Tab>", "<C-W>w", {silent = true})

-- Navegação entre buffers
keymap("n", "<C-l>", ":bn<CR>", {noremap = true})
keymap("n", "<C-a>", ":bp<CR>", {noremap = true})
keymap("n", "<leader>q", ":bd<CR>", {silent = true})

-- Resize da janelas
-- Vertical
keymap("n", "<C-w>-", "<C-w>5-", {noremap = true})
keymap("n", "<C-w>=", "<C-w>5+", {noremap = true})
-- Horizontal
keymap("n", "<C-w>,", "<C-w>5<", {noremap = true})
keymap("n", "<C-w>.", "<C-w>5>", {noremap = true})

-- Center the cursor vertically when moving to the next word during a search.
keymap("n", "n", "nzz", {noremap = true})
keymap("n", "N", "Nzz", {noremap = true})

-- Hlsearch
opt.hlsearch = true
vim.g["incsearch#auto_nohlsearch"] = 1
keymap("n", "n",  "<Plug>(incsearch-nohl-n)", {silent = true})
keymap("n", "N", "<Plug>(incsearch-nohl-N)", {silent = true})
keymap("n", "*", "<Plug>(incsearch-nohl-*)", {silent = true})
keymap("n", "#", "<Plug>(incsearch-nohl-#)", {silent = true})
keymap("n", "g*", "<Plug>(incsearch-nohl-g*)", {silent = true})
keymap("n", "g#", "<Plug>(incsearch-nohl-g#)", {silent = true})
keymap("n", "<Esc><Esc>", ":<C-u>nohlsearch<CR>", {noremap = true})
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

keymap( "n", "<F9>", ":Telescope file_browser<CR>", { noremap = true })
