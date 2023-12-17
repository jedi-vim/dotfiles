local M = {}

local ok_nls, nls = pcall("require", "null-ls")
if not ok_nls then
  return
end

local ok_nls_utils, nls_utils = pcall("require", "null-ls.utils")
if not ok_nls_utils then
  return
end

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local actions = nls.builtins.code_actions

local sources = {
  -- formatting
  formatting.prettierd,
  formatting.shfmt,
  formatting.fixjson,
  formatting.black,
  formatting.isort,

  -- diagnostics
  diagnostics.write_good,
  diagnostics.eslint_d,
  -- diagnostics.flake8,
  -- diagnostics.credo,
  -- diagnostics.zsh,

  -- code actions
  actions.gitsigns,
  -- actions.gitrebase,
  -- actions.refactoring

  -- hover
  -- b.hover.dictionary
}

function M.setup(opts)
  nls.setup {
    -- debug = true,
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }
end

return M
