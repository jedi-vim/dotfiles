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
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup {
    ensure_installed = required_servers
  }
end

return M
