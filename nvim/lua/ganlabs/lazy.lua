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
  }
})
