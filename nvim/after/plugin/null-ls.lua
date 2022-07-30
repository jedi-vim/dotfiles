local null_ls = require("null-ls")
local nls_utils = require "null-ls.utils"
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local sources = {
     -- Python
    diagnostics.flake8,
    formatting.black.with({ extra_args = { "--quiet" } }),
    formatting.isort,

    -- Lua
    -- diagnostics.luacheck,
    -- formatting.lua_format,

   -- JavaScript
    -- formatting.prettier
}

null_ls.setup({
    sources = sources,
    root_dir = nls_utils.root_pattern ".git",
})
