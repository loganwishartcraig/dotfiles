local handlers = require("ganlabs.lsp.handlers")
local augroup = vim.api.nvim_create_augroup("eslint_lsp", {})

return {
  on_attach = function(client, bufnr) 
    handlers.on_attach(client, bufnr)

    -- Should eventually not be needed (bug that it's not added by lsp)
    client.resolved_capabilities.document_formatting = true

    -- Support formatting on save
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              vim.lsp.buf.formatting_sync(nil, 2000)
          end,
      })
    end
  end
}
