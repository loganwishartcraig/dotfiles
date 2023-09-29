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
  integration = {
    nvimtree = {
      enabled = true,
      show_root = true, -- makes the root folder not transparent
      transparent_panel = false, -- make the panel transparent
    }
  }
})

-- Set theme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
