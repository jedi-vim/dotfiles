local fn = vim.fn
local packer_bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("Installing packer...")
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup { function(use)
  use {
    'wbthomason/packer.nvim',
    opt = false
  }
  use 'tpope/vim-commentary'     -- "gc" to comment visual regions/lines
  use 'mg979/vim-visual-multi'   -- Multicursor
  use 'haya14busa/incsearch.vim' -- Increase search
  use 'tpope/vim-surround'       -- Surround sugar
  use 'rcarriga/nvim-notify'

  use({
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  })

  --Themes
  use { 'ellisonleao/gruvbox.nvim' , tag="1.0.0" }
  -- use({ "catppuccin/nvim", as = "catppuccin" })
  -- use 'shaunsingh/nord.nvim'
  -- use {
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --       require("github-theme").setup({theme_style = "light_colorblind"})
  --   end
  -- }

  -- Add indentation guides even on blank lines
  use { 
    "lukas-reineke/indent-blankline.nvim", 
    tag="v2.20.0"
  }
  -- Friendly start screen
  use 'mhinz/vim-startify'

  -- UI to select things (files, grep results, open buffers...)
  use {
    "nvim-telescope/telescope.nvim",
    tag="0.1.1",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
  }

  -- File Explorer
  use {
    "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    }
  }
  -- A tree like view for symbols in Neovim
  use "simrat39/symbols-outline.nvim"

  -- Adds new features and capabilities to wildmenu
  use {
    "gelguy/wilder.nvim",
    run = ":UpdateRemotePlugins"
  }
  -- buffer tabs at top
  use {
    "akinsho/nvim-bufferline.lua",
  }
  -- a smooth scrolling neovim plugin written in lua
  use 'karb94/neoscroll.nvim'
  -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim', 
    tag="v0.6",
    requires = { 'nvim-lua/plenary.nvim' },
  }
  -- Sintax hihjlight based on language
  use {"nvim-treesitter/nvim-treesitter-textobjects", commit="249d90a"}
  use {"nvim-treesitter/nvim-treesitter-context", tag="compat/0.7"}
  use {
    'nvim-treesitter/nvim-treesitter',
    tag="v0.8.0",
    run = ':TSUpdate',
    requires = {
      "nvim-treesitter/tree-sitter-query",
      "nvim-treesitter/nvim-treesitter-refactor",
      "p00f/nvim-ts-rainbow",
    }
  }

  -- inactive portions of the code you're not editing
  use "folke/twilight.nvim"

  -- Docs and completion for the nvim lua API.
  use "folke/neodev.nvim"

  -- Quickstart configurations for the Nvim LSP client
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "ray-x/lsp_signature.nvim",
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

    }
  }

  -- Snippets engine
  use "L3MON4D3/LuaSnip"

  -- A completion engine plugin
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "quangnguyen30192/cmp-nvim-tags",
      "ray-x/cmp-treesitter",
      "onsails/lspkind-nvim",
      "saadparwaiz1/cmp_luasnip",
    }
  }

  -- lsp, completion, linting and snippets
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "SmiteshP/nvim-gps",
      "ThePrimeagen/refactoring.nvim",
    }
  }

  -- A pretty list for showing diagnostics, references etc.
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
      vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
    end,
  }

  -- A blazing fast and easy to configure neovim statusline plugin
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
      { 'nvim-lua/lsp-status.nvim' },
    },
  }

  -- A neovim plugin that shows colorcolumn dynamically
  use {
    'Bekaboo/deadcolumn.nvim',
    config = function()
      require("deadcolumn").setup {}
    end
  }

  -- NeoGit
  use {
    'NeogitOrg/neogit',
    commit="089d388876a535032ac6a3f80e19420f09e4ddda",
    requires = 'nvim-lua/plenary.nvim',
    config= function()
      local neogit = require("neogit")
      neogit.setup{}
      vim.keymap.set("n", "<leader>g", neogit.open, {desc="Neo [g]it"})
    end
  }

  -- A search panel for neovim.
  use {
    'nvim-pack/nvim-spectre',
    requires= 'nvim-lua/plenary.nvim',
  }

  -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon
  use { "kyazdani42/nvim-web-devicons", tag="nerd-v2-compat" }

  if packer_bootstrap then
    vim.notify("Installing plugins...")
    require("packer").sync()
  end
end,
  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
}
