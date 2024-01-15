local js_formatters = { "eslint_d", { "prettierd", "prettier" } }

return {
  config = function()
    require("conform").setup({
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true
      -- },
      -- -- Doesn't work
      -- formatters = {
      --   ts_organize_imports = {
      --     command = ":OrganizeImports"
      --   }
      -- },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "golines", "gofmt" },
        python = { "isort", "black" },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        javascript = js_formatters,
        typescript = js_formatters,
        typescriptreact = js_formatters,
        javascriptreact = js_formatters,
      }
    })

    -- Auto-save formatting
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        -- if vim.fn.exists(':OrganizeImports') > 0 then vim.cmd('OrganizeImports') end
        require("conform").format({ bufnr = args.buf, timeout_ms = 500, lsp_fallback = true })
      end,
    })

    -- Format command
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end
}


