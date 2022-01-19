local actions = require("telescope.actions")
require("telescope").setup(
  {defaults = {mappings = {i = {["<Esc>"] = actions.close}}}}
)
local opts = {noremap = true}
local mappings = {
  {"n", "<Leader>b", [[<Cmd>Telescope buffers<CR>]], opts},
  {"n", "<Leader>f", [[<Cmd>Telescope git_files<CR>]], opts},
  {"n", "<Leader>h", [[<Cmd>Telescope oldfiles<CR>]], opts},
  {"n", "<Leader>g", [[<Cmd>Telescope live_grep<CR>]], opts},
  {"n", "<Leader>t", [[<Cmd>Telescope tags<CR>]], opts},
  {"n", "<Leader>bt", [[<Cmd>Telescope current_buffer_tags<CR>]], opts},
  {"n", "<F10>", [[<Cmd>Telescope help_tags<CR>]], opts}
}
for _, val in pairs(mappings) do
  vim.api.nvim_set_keymap(unpack(val))
end

require("telescope").load_extension "file_browser"
