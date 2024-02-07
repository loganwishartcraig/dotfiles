local js_linters = { "eslint" }

return {
  config = function()
    require("lint").linters_by_ft = {
      jsonlint = { "jsonlint" },
      javascript = js_linters,
      typescript = js_linters,
      typescriptreact = js_linters,
      javascriptreact = js_linters,
      ['*'] = { 'cspell' }
    }

    -- Lint on enter, save, insert leave
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
      pattern = "*",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}

