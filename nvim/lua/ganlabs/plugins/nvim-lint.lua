local js_linters = { "eslint_d" }

return {
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      jsonlint = { "jsonlint" },
      javascript = js_linters,
      typescript = js_linters,
      typescriptreact = js_linters,
      javascriptreact = js_linters,
      -- ['*'] = { 'cspell' }
    }

    -- Lint on enter, save, insert leave
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
      pattern = "*",
      callback = function()
        lint.try_lint()
        -- lint.try_lint("cspell")
        -- lint.try_lint("codespell")
      end,
    })
  end,
}
