local opt = vim.opt_local
opt.autoindent = true
opt.cindent = true
opt.cinwords = "if,elif,else,for,while,try,except,finally,def,class,with,match,case,async"
opt.colorcolumn = "80"
opt.copyindent = true
opt.expandtab = true
opt.formatoptions = "jntcoqlr" -- Inclui "r" para comentários
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 8
opt.smartindent = true -- Melhora a indentação automática
opt.breakindent = true -- Mantém a indentação em quebras de linha
opt.textwidth = 79 -- Segue o padrão PEP 8

vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.py" },
  group = vim.api.nvim_create_augroup("py-fstring", { clear = true }),
  callback = function(params)
    -- Se o caractere inserido não for '{', sai da função
    if vim.v.char ~= "{" then
      return
    end

    -- Obtenção da posição do cursor (linha e coluna)
    local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Pega a posição do cursor (linha e coluna)
    local row, col = cursor_pos[1] - 1, cursor_pos[2] -- Ajusta para indexação zero

    -- Inicializa o parser do Tree-sitter
    local parser = vim.treesitter.get_parser(0, "python")
    if not parser then
      return
    end

    -- Faz o parse e obtém a árvore sintática
    local tree = parser:parse()[1] -- Pega a primeira árvore gerada
    local root = tree:root() -- Pega a raiz da árvore

    -- Encontra o nó em que o cursor está localizado
    local node = root:named_descendant_for_range(row, col, row, col)
    if not node then
      return
    end

    -- Verifica se o nó é uma string, caso contrário tenta o nó pai
    if node:type() ~= "string" then
      node = node:parent()
    end

    -- Se ainda assim o nó não for uma string, sai da função
    if not node or node:type() ~= "string" then
      return
    end

    -- Obtém a posição do nó (início da string)
    local start_row, start_col, _, _ = node:range()

    -- Verifica o primeiro caractere da string para garantir que não haja duplicação de 'f'
    local first_char = vim.api.nvim_buf_get_text(params.buf, start_row, start_col, start_row, start_col + 1, {})[1]
    if first_char == "f" then
      return
    end

    vim.schedule(function()
      vim.api.nvim_buf_set_text(params.buf, start_row, start_col, start_row, start_col, { "f" })
    end)
  end,
})
