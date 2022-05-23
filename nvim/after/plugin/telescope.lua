local ok, tl = pcall(require, "telescope")
if not ok then
    return
end

local actions = require("telescope.actions")

tl.setup(
  {defaults = {mappings = {i = {["<Esc>"] = actions.close}}}}
)

vim.cmd[[
command! -nargs=0 Ag lua require("config.telescope.ag").search()
]]

local opts = {noremap = true}
local mappings = {
  {"n", "<Leader>b", [[<Cmd>Telescope buffers<CR>]], opts},
  {"n", "<Leader>f", [[<Cmd>Telescope git_files<CR>]], opts},
  {"n", "<Leader>h", [[<Cmd>Telescope oldfiles<CR>]], opts},
  {"n", "<F10>", [[<Cmd>Telescope help_tags<CR>]], opts},
  {"n", "<Leader>g", [[<Cmd>Ag<CR>]], opts},
  -- git
  {"n", "<Leader>bc", [[<Cmd>Telescope git_bcommits<CR>]], opts},
  -- Git Status
  {"n", "<Leader>gs", [[<Cmd>Telescope git_status<CR>]], opts},
  {"n", "<Leader>gb", [[<Cmd>Telescope git_branches<CR>]], opts},
  -- lsp symbols
  {"n", "<Leader>t", [[<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>]], opts},
  -- lsp  code actions
  {"n", "<space>ca", [[<Cmd>Telescope lsp_code_actions<CR>]], opts}
}
for _, val in pairs(mappings) do
  vim.api.nvim_set_keymap(unpack(val))
end

tl.load_extension("notify")
