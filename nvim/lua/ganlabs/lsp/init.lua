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

local build_handler = function(name)
  return function()
    local l_opts = require("ganlabs.lsp.settings." .. name)
    lspconfig[name].setup(vim.tbl_deep_extend("force", {}, opts, l_opts))
  end
end

handlers.setup()
mason_lspc.setup()
mason_lspc.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = handlers.on_attach,
      capabilities = handlers.capabilities,
    }
  end,
  ['eslint'] = build_handler('eslint'),
  ['tsserver'] = build_handler('tsserver'),
  ['jsonls'] = build_handler('jsonls'),
  ['lua_ls'] = build_handler('lua_ls'),
}
