local colorscheme = "catppuccin"

-- Catppuccin setup
local theme_ok, catppuccin = pcall(require, "catppuccin")

if not theme_ok then
  return
end

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
catppuccin.setup()

-- Set theme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
