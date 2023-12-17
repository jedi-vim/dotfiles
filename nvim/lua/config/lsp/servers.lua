local M = {}


M.setup = function()
  local required_servers = {
    -- "sumneko_lua", -- lua
    "pyright",     -- python
    "gopls",       -- golang
    "tsserver",    -- js, jsx, tsx
    "bashls",      -- bash
    "yamlls",      -- yaml
    "vimls",       -- vim
    "jsonls",      -- json
    "sqlls",       -- sql
  }

  local ok, lspconfig = pcall("require", "lspconfig")
  if not ok then
    return
  end

  local mason_ok, mason = pcall("require", "mason")
  if not mason_ok then
    return
  end
  mason.setup {}
  
  local mlsp_ok, mason_lspconfig = pcall("require", "mason-lspconfig")
  if not mlsp_ok then
    return
  end

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

  -- local capabilities = require('config.lsp.handlers').capabilities
  -- for _, server_name in pairs(required_servers) do
  --   local server = lspconfig[server_name]
  --   if not server then
  --     vim.notify("LspConfig: Server Not Installed ", server_name)
  --   else
  --     server.setup { capabilities = capabilities }
  --   end
  -- end
end

return M
