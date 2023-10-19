local js_formatters = { { "eslint_d", "prettierd", "prettier" } }

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true
  },
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "golines", "gofmt" },
    python = { "isort", "black" },
    javascript = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
    javascriptreact = js_formatters,
  }
})
