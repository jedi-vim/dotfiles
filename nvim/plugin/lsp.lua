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

-- require("config.lsp.null-ls").setup(opts)
require("config.lsp.notify").setup()

lsp_installer.on_server_ready(function(server)
    -- if server.name == "pyright" then
    --     local pyright_opts = require("config.lsp.settings.pyright")
    --         opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    -- end
    server:setup(opts)
end)

-- diagnostics
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    float = {
        source = "always",
    },
    severity_sort = true,
    --[[ virtual_text = {
      prefix = "»",
      spacing = 4,
    }, ]]
    signs = true,
    update_in_insert = false,
})
