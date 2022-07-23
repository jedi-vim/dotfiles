local M = {}

M.setup = function()
    -- check for missing lsp servers and install them
    -- lsp servers
    local ok, servers = pcall(require, "nvim-lsp-installer.servers")
    if not ok then
      return
    end

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
    for _, svr in pairs(required_servers) do
      local ok, lsp_server = servers.get_server(svr)
      if ok then
        if not lsp_server:is_installed() then
          lsp_server:install()
        end
      end
    end
end

return M
