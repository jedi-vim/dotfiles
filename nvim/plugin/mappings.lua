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
  vim.notify("Config reloaded")
end
vim.cmd('command! ReloadConfig lua ReloadConfig()')
keymap("n", "<leader>sv", "<Cmd>lua ReloadConfig()<CR>", { silent = true, noremap = true })

-- Copiar para o clip board
keymap("v", "yy" , '"+y')

-- Atalho para mover blocos de texto
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Mudar para proxima janela
function SwitchWindow()
  local current_win = vim.api.nvim_get_current_win()

  -- Tenta alternar para a próxima janela, ignorando notificações
  vim.cmd("wincmd w")
  
  -- Verifica se a janela é uma notificação ou pop-up
  while vim.fn.win_gettype() == "popup" or vim.fn.win_gettype() == "notification" do
    -- Se for uma janela de notificação, pula para a próxima
    vim.cmd("wincmd w")
    
    -- Se voltar à janela original, interrompe o loop
    if vim.api.nvim_get_current_win() == current_win then
      break
    end
  end
end

keymap("n", "<Tab>", SwitchWindow, { silent = true, noremap = true })

-- Navegação entre buffers
function CloseBuffer()
  -- Obtém o buffer atual e a lista de buffers abertos
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  -- Identifica a posição do buffer atual na lista de buffers
  local current_buf_index = nil
  for i, buf in ipairs(buffers) do
    if buf.bufnr == current_buf then
      current_buf_index = i
      break
    end
  end

  -- Fecha o buffer atual
  vim.api.nvim_buf_delete(current_buf, { force = true })

  -- Verifica se existe um buffer à direita, e foca nele
  if current_buf_index < #buffers then
    vim.api.nvim_set_current_buf(buffers[current_buf_index + 1].bufnr)
  -- Se não houver, foca no buffer à esquerda
  elseif current_buf_index > 1 then
    vim.api.nvim_set_current_buf(buffers[current_buf_index - 1].bufnr)
  end
end

keymap("n", "<C-l>", ":bn<CR>")
keymap("n", "<C-a>", ":bp<CR>")
keymap("n", "<leader>q", CloseBuffer, {silent = true})

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


