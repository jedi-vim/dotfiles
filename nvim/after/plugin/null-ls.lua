local ok_nls, nls = pcall("require", "null-ls")
if not ok_nls then
  return
end

local ok_nls_utils, nls_utils = pcall("require", "null-ls.utils")
if not ok_nls_utils then
  return
end

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local sources = {
     -- Python
    diagnostics.flake8,
    formatting.black.with({ extra_args = { "--quiet" } }),
    formatting.isort,

    -- Lua
    diagnostics.luacheck,
    formatting.lua_format,

   -- JavaScript
    formatting.prettier
}

null_ls.setup({
    sources = sources,
    root_dir = nls_utils.root_pattern ".git",
})
