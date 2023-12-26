local status_ok, plugin = pcall(require, "lazy")
if not status_ok then
  return
end

plugin.setup({
  "folke/which-key.nvim",

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

  -- Movement
  { "loganwishartcraig/vim-kitty-navigator", build = 'yes | cp -f ./*.py ~/.config/kitty/' },
})
