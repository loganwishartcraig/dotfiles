local M = {}

M.config = function()
  local mapping = require("ganlabs.keymaps")
  require("Comment").setup {
    padding = true,
    ignore = '^$',
    toggler = {
      line = mapping.commments.toggleLine,
      block = mapping.commments.toggleBlock
    },
    opleader = {
      line = mapping.commments.opLeaderLine,
      block = mapping.commments.opLeaderBlock
    },
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  } 
end

return M
