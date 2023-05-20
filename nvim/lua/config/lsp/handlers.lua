local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {properties = { "documentation", "detail", "additionalTextEdits" }}
M.capabilities = capabilities


M.on_attach = function(client, _)
  -- Lsp Mappings
  local opts = { silent = true }
  local mappings = {
    { "n", "gD",         [[<Cmd>lua vim.lsp.buf.declaration()<CR>]],                                                 opts },
    { "n", "gd",         [[<Cmd>lua vim.lsp.buf.definition()<CR>]],                                                  opts },
    { "n", "<leader>rn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]],                                                      opts },
    { "i", "<C-x>",      [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]],                                              opts },
    { "n", "K",          [[<cmd>lua vim.lsp.buf.hover()<CR>]],                                                       opts },
    { "n", "<leader>fm", [[<cmd> lua vim.lsp.buf.format()<CR>]],                                                     opts },
    { "n", "<leader>ca", [[<cmd> lua vim.lsp.buf.code_action()<CR>]],                                                opts },
    { "n", "gr",         [[<Cmd>lua require('telescope.builtin').lsp_references({ path_display = 'shorten' })<CR>]], opts },
    { "n", "<leader>bt", [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],                       opts },
    { "n", "]e",         [[<Cmd>lua vim.diagnostic.goto_next()<CR>]],                                                opts },
    { "n", "[e",         [[<Cmd>lua vim.diagnostic.goto_prev()<CR>]],                                                opts }
  }
  for _, map in pairs(mappings) do
    vim.keymap.set(unpack(map))
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
      vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
      )
  end

  require('lsp_signature').on_attach(client)
end

return M
