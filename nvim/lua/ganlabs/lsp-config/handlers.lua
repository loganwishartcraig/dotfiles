local build_handler = function(opts, name)
  return function()
    local lspconfig = require('lspconfig')
    local l_opts = require("ganlabs.lsp-config." .. name)
    lspconfig[name].setup(vim.tbl_deep_extend("force", {}, opts, l_opts))
  end
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

local function lsp_format_on_save(client, bufnr)
  if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
              vim.lsp.buf.format({ async = false })
          end,
      })
  end
end

local function on_attach(client, bufnr)
  lsp_highlight_document(client)
  lsp_format_on_save(client, bufnr)
end

return {
  build_handler = build_handler,
  on_attach = on_attach
}
