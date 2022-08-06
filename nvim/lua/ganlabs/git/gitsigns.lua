local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
  return
end

local keymaps = require("ganlabs.keymaps")

gitsigns.setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    keymaps.gitsigns(gs, bufnr)
  end
}
