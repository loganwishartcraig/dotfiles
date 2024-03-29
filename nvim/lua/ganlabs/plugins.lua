local fn = vim.fn

-- Auto install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocmd to reload plugins
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Intial packer config
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- Core
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Colorscheme
  use { "catppuccin/nvim", as = "catppuccin" }
  -- use { "ronisbr/nano-theme.nvim" }

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip"

  -- LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "stevearc/conform.nvim"
  use "mfussenegger/nvim-lint"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Explorer
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  -- Motions
  use "bkad/CamelCaseMotion"

  -- Visual Aids
  use "jinh0/eyeliner.nvim"

  -- Editor
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "machakann/vim-sandwich"
  use { "loganwishartcraig/vim-kitty-navigator",
    run = 'yes | cp -f ./*.py ~/.config/kitty/' }
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons' }

  use "nvim-pack/nvim-spectre"

  -- Zenmode
  use { "folke/zen-mode.nvim" }
  use { "folke/twilight.nvim" }

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'akinsho/git-conflict.nvim'
  use { -- Could (should) be lazy loaded
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  }
  use {
    "NeogitOrg/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
    }
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
