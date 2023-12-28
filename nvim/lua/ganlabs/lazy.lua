local status_ok, plugin = pcall(require, "lazy")
if not status_ok then
  return
end

plugin.setup({
  "folke/which-key.nvim",

  -- Theme
  { "catppuccin/nvim", name = "catpuccin", priority = 1000 },

  -- Editor
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeFindFileToggle", "NvimTreeToggle"},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("ganlabs.plugins.nvim-tree").config
  },
  {
    'nvim-telescope/telescope.nvim', 
    branch = '0.1.x',
    cmd = {"Telescope"},
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = require("ganlabs.plugins.telescope").config
  },
  {
    'akinsho/bufferline.nvim', 
    event = 'BufAdd',
    version = "*", 
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = require("ganlabs.plugins.bufferline").config
  },

  -- Editing
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = require("ganlabs.plugins.nvim-surround").config
  },
  { "bkad/CamelCaseMotion" },
  { 
    "numToStr/Comment.nvim", 
    config = require('ganlabs.plugins.comment').confg
  },

  -- Movement
  { "loganwishartcraig/vim-kitty-navigator", build = 'yes | cp -f ./*.py ~/.config/kitty/' },

  -- TresSitter
  { 
    "nvim-treesitter/nvim-treesitter",
    version = false, 
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = { 
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    config = require("ganlabs.plugins.treesitter").config
  },
  { 
    "windwp/nvim-ts-autotag",
    event="InsertEnter",
    opts = {}
  },
  { 
    "windwp/nvim-autopairs", 
    event="InsertEnter",
    config = require("ganlabs.plugins.nvim-autopairs").config 
  },
  { 
    "JoosepAlviste/nvim-ts-context-commentstring",  
    event="InsertEnter",
    opts = {}
  }
})
