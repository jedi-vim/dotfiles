local M = {}

M.setup = function()
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
end

return M
