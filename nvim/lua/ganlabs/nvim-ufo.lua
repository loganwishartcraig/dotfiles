local ok, ufo = pcall(require, "ufo")
if not ok then
  return
end

local M = {}

M.register_capabilities = function(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
end

M.setup = function()
  ufo.setup()
end

return M;
