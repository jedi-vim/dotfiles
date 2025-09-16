local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")

telescope.setup(
  {
    defaults = {
      mappings = { i = { ["<Esc>"] = actions.close } },
      layout_strategy = 'vertical',  -- Usa o layout horizontal
      layout_config = {
        horizontal = {
          preview_width = 0.6,         -- Define a largura da prévia (60% da tela)
          prompt_position = 'top',     -- Posiciona o prompt no topo
        },
      },
      sorting_strategy = 'ascending',  -- Ordena os resultados em ordem ascendente
      -- path_display = { 'shorten' },    -- Exibe o path de forma abreviada
    },
    pickers = {
      lsp_references = {
        show_line = false,             -- Oculta a linha de referência no painel esquerdo
        layout_config = {
          horizontal = {
            preview_width = 0.5,       -- Sobrescreve a largura da prévia para LSP references
          },
        },
      },
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

local opts = {}
local mappings = {
  -- Buffers Opened
  { "n", "<Leader>b", ":lua require'telescope.builtin'.buffers{}<CR>", opts },
  -- Git Files
  { "n", "<Leader>f", [[<Cmd>Telescope git_files<CR>]], opts },
  -- Project Files
  { "n", "<leader>g", require('telescope.builtin').live_grep, opts },
  -- Old Files
  { "n", "<Leader>h", [[<Cmd>Telescope oldfiles<CR>]], opts },
  -- Jumped List
  { "n", "<Leader>jp", [[<Cmd>Telescope jumplist<CR>]], opts },
  { "n", "<F10>", [[<Cmd>Telescope help_tags<CR>]], opts },
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
