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

  -- GruvBox Theme, the greatest
  use { 
    'ellisonleao/gruvbox.nvim', 
    requires = {"itchyny/lightline.vim"}
  }
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
      requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim", "nvim-telescope/telescope-file-browser.nvim"},
      config = [[require("config.telescope")]],
  }
  -- buffer tabs at top
  use({
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({ options = { numbers = "both" } })
    end,
  })
  -- -- Add git related info in the signs columns and popups
  use {
    "lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim"}
  } 
  -- use {
  --   "nvim-treesitter/nvim-treesitter", 
  --   requires = {
  --     'nvim-treesitter/nvim-treesitter-refactor',
  --     'nvim-treesitter/nvim-treesitter-textobjects',
  --   },
  --   run = "TSUpdate"
  -- }
   use({ "folke/lua-dev.nvim" })   
   use {
     "neovim/nvim-lspconfig",
     requires = {"williamboman/nvim-lsp-installer"},
     config = [[require("config.lsp")]],
   }
   
   use {
     "hrsh7th/nvim-cmp",
     config = function()
      require("config.cmp")
     end,
     requires = {
       "f3fora/cmp-spell",
       "hrsh7th/cmp-buffer",
       "hrsh7th/cmp-nvim-lsp",
       "hrsh7th/cmp-nvim-lua",
       "hrsh7th/cmp-path",
       "hrsh7th/cmp-vsnip",
       "octaltree/cmp-look",
       "quangnguyen30192/cmp-nvim-tags",
       "quangnguyen30192/cmp-nvim-ultisnips",
       "ray-x/cmp-treesitter",
       "saadparwaiz1/cmp_luasnip",
     }}

     if packer_bootstrap then
        vim.notify("Installing plugins...")
        require("packer").sync()
     end
end)

