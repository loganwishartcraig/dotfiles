local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
  return
end

local actions = require("diffview.actions")

diffview.setup({
  view = {
    merge_tool = {
      layout = "diff3_mixed"
    }
  }
})

-- TODO: Custom keymaps
