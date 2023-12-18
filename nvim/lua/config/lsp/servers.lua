local M = {}

M.setup = function()
  local required_servers = {
    "lua_ls",      -- lua
    "pyright",     -- python
    "gopls",       -- golang
    "tsserver",    -- js, jsx, tsx
    "bashls",      -- bash
    "yamlls",      -- yaml
    "vimls",       -- vim
    "jsonls",      -- json
    "sqlls",       -- sql
  }
  require("mason").setup {}
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup {
    ensure_installed = required_servers
  }
  mason_lspconfig.setup_handlers({
    function(server_name)
      local lsp_local_config = require("config.lsp.handlers")
      local config = {
        on_attach = lsp_local_config.on_attach,
        capabilities = lsp_local_config.capabilities,
        handlers = lsp_local_config.handlers
      }
      lspconfig[server_name].setup(config)
    end
  })
end

return M
