require("lint").linters_by_ft = {
  jsonlint = { "jsonlint" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  javascriptreact = { "eslint_d" },
}

-- Lint on enter, save, insert leave, text changed in normal mode
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    require("lint").try_lint()
  end,
})
