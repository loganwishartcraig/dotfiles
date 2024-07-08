local keymaps = require('ganlabs.keymaps')

local M = {
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = require('gitsigns')
      keymaps.gitsigns(gs, buffer)
    end
  }
}

return M
