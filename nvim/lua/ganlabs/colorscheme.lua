local systemTheme = vim.fn.system("getSystemTheme")
local colorscheme = "catppuccin"

-- Catppuccin setup
local theme_ok, catppuccin = pcall(require, "catppuccin")

if not theme_ok then
  return
end

local flavor

if string.match(systemTheme, "Dark") then
  flavor = "mocha"
else
  flavor = "latte"
end

vim.g.catppuccin_flavour = flavor -- latte, frappe, macchiato, mocha
catppuccin.setup({
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    nvimtree = {
      enabled = true,
      show_root = true,          -- makes the root folder not transparent
      transparent_panel = false, -- make the panel transparent
    },
    -- lsp_trouble = true, -- Didn't like how this looked
    mason = true,
    illuminate = true,
    indent_blankline = {
      enabled = true,
      scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = false,
    },
  }
})

-- Set theme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
