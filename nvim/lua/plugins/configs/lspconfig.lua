local lspconfig = require('lspconfig')
local map = require("core.utils").map_binding

local on_attach = function(client, bufnr) 

	local opts = { buffer = bufnr } 

	map("n", "gD", vim.lsp.buf.declaration, opts)

end

print("running")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
   documentationFormat = { "markdown", "plaintext" },
   snippetSupport = true,
   preselectSupport = true,
   insertReplaceSupport = true,
   labelDetailsSupport = true,
   deprecatedSupport = true,
   commitCharactersSupport = true,
   tagSupport = { valueSet = { 1 } },
   resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
   },
}

lspconfig.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
