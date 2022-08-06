local handlers = require("ganlabs.lsp.handlers")

return {
    on_attach = function(client, bufnr)
        handlers.on_attach(client, bufnr)
        -- this will break with neovim 0.8
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
        client.resolved_capabilities.document_formatting = false
        client.server_capabilities.document_formatting = false
    end
}
