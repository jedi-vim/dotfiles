local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

treesitter.setup {
    ensure_installed = {
        "python", "bash", "cmake", "dockerfile", "go", "javascript", "lua", "make",
        "typescript", "vim", "tsx", "toml", "yaml"
    },
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
        navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<a-*>",
              goto_previous_usage = "<a-#>",
            },
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    textobjects = {
         move = {
             enable = true,
         },
        swap = {
             enable = true,
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

local api = vim.api
local opt = vim.o
api.nvim_create_autocmd({'BufEnter', "BufAdd", "BufNew", "BufNewFile", "BufWinEnter"},
    {
        group = api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
        callback= function ()
            opt.foldmethod = "expr"
            opt.foldexpr = "nvim_treesitter#foldexpr()"
        end
    }
)

--vim.keymap.set("n", "<leader>pg", "[[<cmd>TSPlaygroundToggle<cr>]]")
