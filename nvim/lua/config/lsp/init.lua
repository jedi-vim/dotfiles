-- check for missing lsp servers and install them
-- lsp servers
local required_servers = {
  "sumneko_lua", -- lua
  "pyright", -- python
  "gopls", -- golang
  "tsserver", -- js, jsx, tsx
  "bashls", -- bash
  "yamlls", -- yaml
  "vimls", -- vim
  "jsonls", -- json
  "sqlls", -- sql
}
local servers = require("nvim-lsp-installer.servers")
for _, svr in pairs(required_servers) do
  local ok, lsp_server = servers.get_server(svr)
  if ok then
    if not lsp_server:is_installed() then
      lsp_server:install()
    end
  end
end

local opts = {
    on_attach = require('config.lsp.handlers').on_attach,
    capabilities = require('config.lsp.handlers').capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }),
    }
}

require("config.lsp.null-ls").setup(opts)
require("config.lsp.notify").setup()

require("nvim-lsp-installer").on_server_ready(function(server)
    -- if server.name == "pyright" then
    --     local pyright_opts = require("config.lsp.settings.pyright")
    --         opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    -- end
    server:setup(opts)
end)

