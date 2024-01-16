return {
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    min_count_to_highlight = 2,
    filetypes_denylist = { "NvimTree" },
    large_file_overrides = {
      providers = {
        "lsp"
      },
    },
  }
}
