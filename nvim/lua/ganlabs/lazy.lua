local status_ok, plugin = pcall(require, "lazy")
if not status_ok then
  return
end

plugin.setup({
  "folke/which-key.nvim",

  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = require("ganlabs.plugins.catppuccin").config
  },

  -- Editor
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeFindFileToggle", "NvimTreeToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("ganlabs.plugins.nvim-tree").config
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = { "Telescope" },
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/trouble.nvim' }, -- require trouble for 'open with trouble'
    config = require("ganlabs.plugins.telescope").config
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufAdd',
    -- Commented due to https://github.com/akinsho/bufferline.nvim/issues/903
    -- Should be uncommented when resolved
    -- version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require("ganlabs.plugins.bufferline").config
  },
  {
    'nvim-pack/nvim-spectre',
    event = 'VeryLazy',
    opts = require("ganlabs.plugins.spectre").opts
  },
  {
    "jinh0/eyeliner.nvim",
    event = 'BufAdd',
    opts = require("ganlabs.plugins.eyeliner").opts
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = require("ganlabs.plugins.lualine").opts
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    main = "ibl",
    opts = require("ganlabs.plugins.indent-blankline").opts
  },
  {
    'stevearc/dressing.nvim',
    opts = require("ganlabs.plugins.dressing").opts
  },
  {
    'echasnovski/mini.indentscope',
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = require("ganlabs.plugins.mini-indentscope").config
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = require("ganlabs.plugins.vim-illuminate").config
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    opts = require("ganlabs.plugins.trouble").opts
  },

  -- Editing
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = require("ganlabs.plugins.nvim-surround").config
  },
  { "bkad/CamelCaseMotion" },
  -- {
  --   "numToStr/Comment.nvim",
  --   config = require('ganlabs.plugins.comment').config
  -- },

  -- Movement
  { "loganwishartcraig/vim-kitty-navigator", build = 'yes | cp -f ./*.py ~/.config/kitty/' },

  -- TresSitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = nil,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
      },
    },
    config = require("ganlabs.plugins.treesitter").config,
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      opts = {
        enable_close_on_slash = true
      }
    }
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = require("ganlabs.plugins.nvim-autopairs").config
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy"
  },
  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   event = "InsertEnter",
  --   opts = {},
  --   main = "ts_context_commentstring"
  -- },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = require("ganlabs.plugins.gitsigns").opts
  },

  -- {
  --   'sindrets/diffview.nvim',
  --   event = "VeryLazy",
  --   opts = require("ganlabs.plugins.diffview").opts,
  --   dependencies = { 'nvim-lua/plenary.nvim', 'akinsho/git-conflict.nvim' },
  -- },
  {
    'akinsho/git-conflict.nvim',
    event = "VeryLazy",
    opts = require("ganlabs.plugins.git-conflict").opts
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = require('ganlabs.plugins.nvim-cmp').config,
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        {
          "L3MON4D3/LuaSnip",
          build = "make install_jsregexp",
          dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
          opts = require('ganlabs.plugins.luasnip').opts,
        }
      }
    }
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = require('ganlabs.plugins.mason').opts,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = require('ganlabs.plugins.nvim-lspconfig').opts,
    config = require('ganlabs.plugins.nvim-lspconfig').config,
    dependencies = {
      "hrsh7th/nvim-cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    cmd = { "ConformInfo", "Format", "FormatDisable", "FormatEnable" },
    config = require('ganlabs.plugins.conform').config,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    dependencies = { "mason.nvim" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = require('ganlabs.plugins.nvim-lint').config,
  },

})
