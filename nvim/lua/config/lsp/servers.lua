local M = {}

M.setup = function()
  require("mason").setup {}
  require("mason-lspconfig").setup {
    ensure_installed = {
      "lua_ls",      -- lua
      "pyright",     -- python
      "gopls",       -- golang
      "tsserver",    -- js, jsx, tsx
      "bashls",      -- bash
      "yamlls",      -- yaml
      "vimls",       -- vim
      "jsonls",      -- json
    }
  }
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      if server_name then
        require("lspconfig")[server_name].setup({})
      end
    end
  })
end

return M
