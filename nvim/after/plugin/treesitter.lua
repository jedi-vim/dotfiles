local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

treesitter.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
    },
    autopairs = {
        enable = true,
    },
    refactor = {
        highlight_current_scope = { enable = true },
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = false,
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
     }
}

require'treesitter-context'.setup{
    enable = true,
    throttle = true,
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
            'class',
            'function',
            'def',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
    }
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr"

vim.keymap.set("n", "<leader>pg", "[[<cmd>TSPlaygroundToggle<cr>]]")
