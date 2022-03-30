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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost bootstrap.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
  use {
    'wbthomason/packer.nvim',
    opt=false
  }
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'mg979/vim-visual-multi' -- Multicursor
  use 'haya14busa/incsearch.vim' -- Increase search
  use 'haya14busa/incsearch-fuzzy.vim' -- Increase search with fuzzy strategy
  use 'tpope/vim-surround' -- Surround sugar

  --Themes
  use 'ellisonleao/gruvbox.nvim'
  use 'shaunsingh/nord.nvim'
  -- use {
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --       require("github-theme").setup({theme_style = "light_colorblind"})
  --   end
  -- }


  use({ "kyazdani42/nvim-web-devicons" })
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use({
    "mhinz/vim-startify",
    config = function()
      vim.g.startify_bookmarks = { "~/.config/nvim/lua" }
    end,
  })

  -- UI to select things (files, grep results, open buffers...)
  use {
      "nvim-telescope/telescope.nvim",
      requires = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
       },
      config = [[require("config.telescope")]],
  }
  -- File tree explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require('config.nvim-tree') end
  }
  use {
    "gelguy/wilder.nvim",
    run = ":UpdateRemotePlugins",
    config = function() require("config.wilder") end,
  }
  -- buffer tabs at top
  use({
    "akinsho/nvim-bufferline.lua",
    config = function() require("bufferline").setup {} end,
  })
  -- -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.gitsigns') end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function () require('config.treesitter') end,
    requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "romgrk/nvim-treesitter-context",
        "p00f/nvim-ts-rainbow",
    }
  }

  use {
  "folke/twilight.nvim",
  config = [[require("config.twilight")]],
  }

  use({ "folke/lua-dev.nvim" })

  use {
     "neovim/nvim-lspconfig",
     requires = {
         "williamboman/nvim-lsp-installer",
         "ray-x/lsp_signature.nvim",
     },
     config = [[require("config.lsp")]],
  }

  use {'j-hui/fidget.nvim',
        config = [[require("config.fidget")]]
    }

  use {
     "hrsh7th/nvim-cmp",
     config = function()
      require("config.cmp")
     end,
     requires = {
       "hrsh7th/cmp-buffer",
       "hrsh7th/cmp-nvim-lsp",
       "hrsh7th/cmp-nvim-lua",
       "hrsh7th/cmp-path",
       "hrsh7th/cmp-cmdline",
       "quangnguyen30192/cmp-nvim-tags",
       "ray-x/cmp-treesitter",
       "onsails/lspkind-nvim",
  }}
     -- lsp, completion, linting and snippets
   use({ "jose-elias-alvarez/null-ls.nvim" })
   use({
       "folke/trouble.nvim",
       config = function()
           require("trouble").setup({})
           vim.api.nvim_set_keymap("n", "<F8>", "<Cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
       end,
   })
   use {
    'nvim-lualine/lualine.nvim',
     -- after = 'github-nvim-theme',
     requires = {
             {'kyazdani42/nvim-web-devicons', opt = true },
             {'nvim-lua/lsp-status.nvim' },
     },
     config = function()
        require("config.lualine")
     end
  }

     if packer_bootstrap then
        vim.notify("Installing plugins...")
        require("packer").sync()
     end
end)

