require("lint").linters_by_ft = {
  jsonlint = { "jsonlint" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  typescriptreact = { "eslint" },
  javascriptreact = { "eslint" },
  ['*'] = { 'cspell' }
}

-- Lint on enter, save, insert leave
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    require("lint").try_lint()
  end,
})
