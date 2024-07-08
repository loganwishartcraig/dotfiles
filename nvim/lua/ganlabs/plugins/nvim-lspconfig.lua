local keymaps = require("ganlabs.keymaps")
local handlers = require("ganlabs.lsp-config.handlers")

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local function lsp_commands(bufnr)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]]
end

return {
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      underline = true,
      update_in_insert = false,
      signs = {
        active = signs,
      },
      virtual_text = false,
      -- virtual_text = {
      --   spacing = 4,
      --   source = "if_many",
      --   prefix = "●",
      --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      --   -- prefix = "icons",
      -- },
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
    -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
    -- Be aware that you also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = false,
    },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(default_capabilities)
    local mason_lspconfig = require("mason-lspconfig")

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local bufnr = ev.buf
        lsp_commands(bufnr)
        keymaps.lsp_keymaps(bufnr)
      end
    })

    vim.diagnostic.config(opts.diagnostics)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    local server_opts = {
      on_attach = handlers.on_attach,
      capabilities = cmp_capabilities,
    }

    -- mason_lspc.setup()
    mason_lspconfig.setup_handlers {
      function(server_name)
        -- Skip setting up eslint as an LSP server.
        -- We instead rely on nvim-lint to handle this
        if server_name ~= 'eslint' then
          lspconfig[server_name].setup(server_opts)
        end
      end,
      ['tsserver'] = handlers.build_handler(server_opts, 'tsserver'),
      ['jsonls'] = handlers.build_handler(server_opts, 'jsonls'),
      ['lua_ls'] = handlers.build_handler(server_opts, 'lua_ls'),
    }
  end
}
