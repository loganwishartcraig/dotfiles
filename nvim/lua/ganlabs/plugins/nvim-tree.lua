local settings = {}

settings.config = function()
  require('nvim-tree').setup {
    disable_netrw = true,
    hijack_netrw = true,
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    view = {
      adaptive_size = true
    },
    actions = {
      open_file = {
        quit_on_open = true,
      }
    }
  } 
end

return settings
