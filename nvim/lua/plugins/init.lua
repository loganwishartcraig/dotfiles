vim.cmd "packadd packer.nvim"  

local plugins = {
	["wbthomason/packer.nvim"] = "wbthomason/packer.nvim",
	["kyazdani42/nvim-web-devicons"] = "kyazdani42/nvim-web-devicons",
	["kyazdani42/nvim-tree.lua"] = {
		"kyazdani42/nvim-tree.lua",
		cmd = {"NvimTreeToggle", "NvimTreeFocus"},
		config = function() 
			require "plugins.configs.nvimtree"
		end,
	},
	["williamboman/nvim-lsp-installer"] = {
		"williamboman/nvim-lsp-installer",
		config = function() 
--			require "plugins.configs.lsp_installer"
		end
	},
	["neovim/nvim-lspconfig"] = {
		"neovim/nvim-lspconfig",
		after = "nvim-lsp-installer",
		module = "lspconfig",
		config = function() 
			require "plugins.configs.lspconfig"
		end,
	}
}

require("core.packer").run(plugins)


