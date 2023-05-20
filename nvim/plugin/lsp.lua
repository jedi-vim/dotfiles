require("config.lsp.notify").setup()
require("config.lsp.servers").setup()
require("config.lsp.diagnostic").setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = false })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.bufnr
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require('config.lsp.handlers').on_attach(client, bufnr)
  end
})
