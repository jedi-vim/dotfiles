local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
  return
end

require('config.lsp.servers').setup()

local opts = {
    on_attach = require('config.lsp.handlers').on_attach,
    capabilities = require('config.lsp.handlers').capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }),
    }
}
lsp_installer.on_server_ready(function(server)
    server:setup(opts)
end)

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    float = {
        source = "always",
    },
    severity_sort = true,
    signs = true,
    update_in_insert = false,
})

require("config.lsp.notify").setup()
