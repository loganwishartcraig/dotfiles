local handlers = require("ganlabs.lsp.handlers")

return {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        handlers.on_attach(client, bufnr)
    end
}
