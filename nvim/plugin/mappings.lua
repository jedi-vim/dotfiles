local keymap = vim.keymap.set

-- LeaderKey
vim.g.mapleader = ","

--Salvar com C-s
keymap("n", "<C-s>", ":w<CR>")

-- Reload vim conf
function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^cnull') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end
vim.cmd('command! ReloadConfig lua ReloadConfig()')
keymap("n", "<leader>sv", "<Cmd>lua ReloadConfig()<CR>", { silent = true, noremap = true })

-- Copiar para o clip board
keymap("v", "yy" , '"+y')

-- Atalho para mover blocos de texto
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Mudar para proxima janela
keymap("n", "<Tab>", "<C-W>w")

-- Navegação entre buffers
keymap("n", "<C-l>", ":bn<CR>")
keymap("n", "<C-a>", ":bp<CR>")
keymap("n", "<leader>q", ":bd<CR>", {silent = true})

-- Resize da janelas
-- Vertical
keymap("n", "<C-w>-", "<C-w>5-")
keymap("n", "<C-w>=", "<C-w>5+")
-- Horizontal
keymap("n", "<C-w>,", "<C-w>5<")
keymap("n", "<C-w>.", "<C-w>5>")

-- Center the cursor vertically when moving to the next word during a search.
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")

-- Hlsearch
vim.opt.hlsearch = true
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

-- Delete a word backwards
keymap("n", "dw", 'vb" _d')

-- Select all
keymap('n', '<leader>sa', 'gg<S-v>G')


