local status_ok, gitconflict = pcall(require, "git-conflict")
if not status_ok then
  return
end

gitconflict.setup {
  default_mapping = false,
  disable_diagnostics = true,
}
