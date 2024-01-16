-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--- Get completion context, i.e., auto-import/target module location.
-- https://github.com/ditsuke/nvim-config/blob/5d22ea749ef64b5d3fec0ad3d6ac457e6dcbeb22/lua/ditsuke/plugins/editor/cmp.lua#L40C1-L63C4
local function get_lsp_completion_context(completion, source)
  local ok, source_name = pcall(function() return source.source.client.config.name end)
  if not ok then
    return nil
  end
  if source_name == "tsserver" then
    return completion.detail
  elseif source_name == "pyright" or source_name == "vtsls" then
    if completion.labelDetails ~= nil then
      return completion.labelDetails.description
    end
  elseif source_name == "gopls" then
    return completion.detail
  end
end

return {
  config = function()
    -- vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      formatting = {
        format = function(entry, vim_item)
          local item_with_kind = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...',
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            -- before = function (entry, vim_item)
            --  return vim_item
            -- end
            preset = 'codicons',
            -- Add custom symbols
            symbol_map = {
              Copilot = "",
              Snippet = ""
            },
          })(entry, vim_item)

          -- https://github.com/ditsuke/nvim-config/blob/5d22ea749ef64b5d3fec0ad3d6ac457e6dcbeb22/lua/ditsuke/plugins/editor/cmp.lua#L243
          item_with_kind.menu = ""
          local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
          if completion_context ~= nil and completion_context ~= "" then
            -- local truncated_context = string.sub(completion_context, -30)
            local truncated_context = string.sub(completion_context, 1, 30)
            if truncated_context ~= completion_context then
              truncated_context = "..." .. truncated_context
            end
            item_with_kind.menu = item_with_kind.menu .. " " .. truncated_context
          end

          item_with_kind.menu_hl_group = "CmpItemAbbr"
          return item_with_kind
        end
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),

      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_locally_jumpable()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      experimental = {
        ghost_text = false,
      },

    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end
}
