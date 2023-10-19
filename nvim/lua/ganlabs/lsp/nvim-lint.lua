local js_formatters = { "eslint_d" }

require("lint").setup({
  linters_by_ft = {
    jsonlint = { "jsonlint" },
    -- go = { "golangcilint" },
    javascript = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
    javascriptreact = js_formatters,
  }
})

-- Lint on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    require("lint").try_lint()
  end,
})
