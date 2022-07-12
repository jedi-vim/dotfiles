local opt = vim.opt_local
opt.autoindent = true
opt.cindent = true
opt.cinwords = "if,elif,else,for,while,try,except,finally,def,class,with"
opt.colorcolumn = "80"
opt.copyindent = true
opt.expandtab = true
opt.formatoptions= "jntcoql"
opt.smartindent = true
opt.shiftwidth = 4
-- opt.smarttab = true
opt.softtabstop = 4
opt.tabstop = 8

local null_ls = require("null-ls")
local nls_utils = require "null-ls.utils"
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local sources = {
    diagnostics.flake8,
    formatting.black,
    formatting.isort
}

null_ls.setup({
    on_attach = require('config.lsp.handlers').on_attach,
    sources = sources,
    root_dir = nls_utils.root_pattern ".git"
})
