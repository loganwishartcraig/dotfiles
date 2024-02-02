local status_ok, plugin = pcall(require, "lazy")
if not status_ok then
  return
end

plugin.setup({
  "folke/which-key.nvim",

  -- Theme
  { "catppuccin/nvim",     name = "catpuccin", priority = 1000 },

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
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = require("ganlabs.plugins.telescope").config
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufAdd',
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require("ganlabs.plugins.bufferline").config
  },
  {
    'nvim-pack/nvim-spectre',
    event = 'VeryLazy',
    opts = {}
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
    opts = {},
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
  {
    "numToStr/Comment.nvim",
    config = require('ganlabs.plugins.comment').config
  },

  -- Movement
  { "loganwishartcraig/vim-kitty-navigator", build = 'yes | cp -f ./*.py ~/.config/kitty/' },

  -- TresSitter
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring"
      },
    },
    config = require("ganlabs.plugins.treesitter").config
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {}
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = require("ganlabs.plugins.nvim-autopairs").config
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "InsertEnter",
    opts = {},
    main = "ts_context_commentstring"
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    opts = require("ganlabs.plugins.gitsigns").opts
  },

  {
    'sindrets/diffview.nvim',
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = require("ganlabs.plugins.diffview").opts,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'akinsho/git-conflict.nvim',
    opts = require("ganlabs.plugins.git-conflict").opts
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
    cmd = { "ConformInfo", "Format" },
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
