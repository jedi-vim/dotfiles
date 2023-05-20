local M = {}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail",
    "additionalTextEdits" }
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.capabilities = capabilities


M.handlers = {
  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }),
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
}


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

  -- Disnostics
  local diagnostic = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
    group = diagnostic,
  })

  -- Signs
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Hightlight
  if client.server_capabilities.document_highlight then
    local lsp_doc_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = lsp_doc_highlight,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.document_highlight()
      end
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = lsp_doc_highlight,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end
  require('lsp_signature').on_attach(client)
end

return M
