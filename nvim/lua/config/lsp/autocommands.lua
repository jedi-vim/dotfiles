vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local buf = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Lsp Mappings
    local opts = { buffer = buf, silent = true }
    local mappings = {
      { "n", "gD",         vim.lsp.buf.declaration,                           opts },
      { "n", "gd",         vim.lsp.buf.definition,                            opts },
      { "n", "<leader>rn", vim.lsp.buf.rename,                                opts },
      { "n", "<C-x>",      vim.lsp.buf.signature_help,                        opts },
      { "n", "K",          vim.lsp.buf.hover,                                 opts },
      { "n", "<leader>fm", vim.lsp.buf.format,                                opts },
      { "n", "<leader>ca", vim.lsp.buf.code_action,                           opts },
      { "n", "gr",         require('telescope.builtin').lsp_references,       opts },
      { "n", "<leader>bt", require('telescope.builtin').lsp_document_symbols, opts },
      { "n", "]e",         vim.diagnostic.goto_next,                          opts },
      { "n", "[e",         vim.diagnostic.goto_prev,                          opts }
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
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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

    -- Capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits"
      }
    }
    capabilities = vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Handlers
    local custom_handlers = {}
    custom_handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = false })
    custom_handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    custom_handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    -- Merge custom handler on defaults
    vim.tbl_extend("force", client.handlers, custom_handlers)

    -- InlayHints: Something broked here
    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint.enable(buf, true)
    -- end

    require('lsp_signature').on_attach(client)
  end
}
)
