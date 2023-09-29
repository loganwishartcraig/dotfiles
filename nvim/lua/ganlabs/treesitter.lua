local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local maps = require('ganlabs.keymaps').treesitter_textobjects

configs.setup {
  -- ensure_installed = "all",
  auto_install = true,
  sync_install = false,
  ignore_install = { "" },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
    disable = { "" }
  },
  context_commentstring = {
    enable = true,
    -- enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = maps.select,
      include_surrounding_whitespace = true
    },
    swap = {
      enable = true,
      swap_next = maps.swap.swap_next,
      swap_previous = maps.swap.swap_previous,
    },
    move = {
      enable = true,
      sset_jumps = true,
      goto_next_start = maps.move.goto_next_start,
      goto_next_end = maps.move.goto_next_end,
      goto_previous_start = maps.move.goto_previous_start,
      goto_previous_end = maps.move.goto_previous_end
    }
  }
}

-- Doesn't work for some reason - module not found on my M1 macbook
-- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
