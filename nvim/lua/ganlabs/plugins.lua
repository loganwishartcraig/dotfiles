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

  -- LSP
  use "stevearc/conform.nvim"
  use "mfussenegger/nvim-lint"

  -- Visual Aids

  -- Editor

  -- Zenmode
  use { "folke/zen-mode.nvim" }
  use { "folke/twilight.nvim" }

  -- Git
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
