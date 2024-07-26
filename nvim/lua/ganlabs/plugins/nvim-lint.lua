local js_linters = { "eslint_d", "cspell" }

return {
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      json = { "jsonlint", "cspell" },
      javascript = js_linters,
      typescript = js_linters,
      typescriptreact = js_linters,
      javascriptreact = js_linters,
    }

    -- Example for overriding args
    -- lint.linters.eslint_d.args = {
    --   "--format",
    --   "json",
    --   "--stdin",
    --   "--stdin-filename",
    --   function()
    --     return vim.api.nvim_buf_get_name(0)
    --   end,
    -- }

    -- Lint on enter, save, insert leave
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
      pattern = "*",
      callback = function()
        lint.try_lint()
        -- Runs cspell on all fts,
        -- disabled because caused bugs in non-code windows
        -- lint.try_lint("cspell")
      end,
    })
  end,
}
