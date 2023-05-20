local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")

telescope.setup(
  {
    defaults = {
      mappings = { i = { ["<Esc>"] = actions.close } }
    },
    project = {
      base_dirs = {
        '~/workspace/',
        { '~/.config/', max_depth = 1 },
      },
      theme = "dropdown"
    }
  }
)

vim.cmd [[
command! -nargs=0 Ag lua require("config.telescope.ag").search()
]]

local opts = {}
local mappings = {
  -- Buffers Opened
  { "n", "<Leader>b", ":lua require'telescope.builtin'.buffers{}<CR>", opts },
  -- Git Files
  { "n", "<Leader>f", [[<Cmd>Telescope git_files<CR>]], opts },
  -- Old Files
  { "n", "<Leader>h", [[<Cmd>Telescope oldfiles<CR>]], opts },
  -- Jumped List
  { "n", "<Leader>jp", [[<Cmd>Telescope jumplist<CR>]], opts },
  { "n", "<F10>", [[<Cmd>Telescope help_tags<CR>]], opts },
  --Silver Seacher, made by me
  { "n", "<Leader>g", [[<Cmd>Ag<CR>]], opts },
  -- Buffer Commits
  { "n", "<Leader>bc", [[<Cmd>Telescope git_bcommits<CR>]], opts },
  -- Git Status
  { "n", "<Leader>gs", [[<Cmd>Telescope git_status<CR>]], opts },
  { "n", "<Leader>gb", [[<Cmd>Telescope git_branches<CR>]], opts },
  -- lsp symbols
  { "n", "<Leader>t", [[<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>]], opts },
  -- Projects
  { 'n', '<C-p>', ":lua require'telescope'.extensions.project.project{}<CR>", opts }
}
for _, val in pairs(mappings) do
  vim.keymap.set(unpack(val))
end

telescope.load_extension "notify"
telescope.load_extension "file_browser"
telescope.load_extension "project"
telescope.load_extension "ui-select"
