local status_ok, neogit = pcall(require, 'neogit')
if not status_ok then
  return
end

neogit.setup({
  integrations = {
    telescope = true,
    diffview = true,
    fzf_lua = true,
  }
})
