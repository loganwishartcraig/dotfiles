local settings = {}

settings.config = function()
  local actions = require("telescope.actions")
  local trouble = require('trouble.providers.telescope')

  require("telescope").setup {
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      }
    },
    defaults = {
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
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
