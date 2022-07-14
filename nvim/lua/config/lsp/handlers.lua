local M = {}
local lsp_util = vim.lsp.util

M.code_action_listener = function()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = lsp_util.make_range_params()
  params.context = context
  vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, _, result)
    -- do something with result - e.g. check if empty and show some indication such as a sign
  end)
end

local lsp_keymaps = function(bufnr)
  local opts = { silent = true}
  local mappings = {
    { "n", "gD", [[<Cmd>lua vim.lsp.buf.declaration()<CR>]], opts },
    { "n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts },
    { "n", "gr", [[<Cmd>lua require('telescope.builtin').lsp_references({ path_display = 'shorten' })<CR>]], opts },
    { "n", "<leader>bt", [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts},
    { "n", "<leader>rn", [[<Cmd>lua vim.lsp.buf.rename()<CR>]], opts },
    { "i", "<C-x>", [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], opts },
    { "n", "]e", [[<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], opts },
    { "n", "[e", [[<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], opts },
  }
  for _, map in pairs(mappings) do
      vim.keymap.set(unpack(map))
  end
end


local lsp_highlight_document = function(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {properties = { "documentation", "detail", "additionalTextEdits" }}
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_signature = require('lsp_signature')

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)

  -- Lsp lsp_signature
  lsp_signature.on_attach(client)
end

return M
