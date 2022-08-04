local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local mason_lspc_ok, mason_lspc = pcall(require, "mason-lspconfig")
if not mason_lspc_ok then
    return
end

require("ganlabs.lsp.lsp-installer")
require("ganlabs.lsp.null-ls")

local handlers = require("ganlabs.lsp.handlers")
local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}

handlers.setup()
mason_lspc.setup()
mason_lspc.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities
        }
    end,
    ['tsserver'] = function()
        local l_opts = require("ganlabs.lsp.settings.tsserver")
        lspconfig['tsserver'].setup(vim.tbl_deep_extend("force", l_opts, opts))
    end,
    ['jsonls'] = function()
        local l_opts = require("ganlabs.lsp.settings.jsonls")
        lspconfig['jsonls'].setup(vim.tbl_deep_extend("force", l_opts, opts))
    end,
    ['sumneko_lua'] = function()
        local l_opts = require("ganlabs.lsp.settings.sumneko_lua")
        lspconfig['sumneko_lua'].setup(vim.tbl_deep_extend("force", l_opts, opts))
    end
}
