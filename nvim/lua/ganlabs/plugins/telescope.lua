local settings = {}

settings.config = function()

  -- local actions = require "telescope.actions"
  require("telescope").setup {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },
      layout_config = {
        horizontal = { height = 0.5 }
      }
    },
  }

  -- Bugfix for folds https://github.com/nvim-telescope/telescope.nvim/issues/699
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      if vim.opt.foldmethod:get() == "expr" then
        vim.schedule(function()
          vim.opt.foldmethod = "expr"
        end)
      end
    end,
  })

end

return settings
