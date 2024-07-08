local settings = {}

settings.config = function()
  require('nvim-surround').setup {
    move_cursor = false,
    keymaps = {
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "sa",
      normal_cur = "saA",
      normal_line = "sA",
      normal_cur_line = "sAA",
      visual = "S",
      visual_line = "gS",
      delete = "sd",
      change = "sr",
      change_line = "sR",
    }
  }
end

return settings
