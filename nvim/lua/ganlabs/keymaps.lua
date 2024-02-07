local M = {}
local opts = { noremap = true, silent = true }

local map = vim.keymap.set
local bf_map = function(bufnr, mode, l, r, o)
  map(mode, l, r, vim.tbl_deep_extend("force", { buffer = bufnr }, o or {}))
end

-- Leader as space
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Pane navigation
map("n", "<C-h>", ":KittyNavigateLeft<CR>", opts)
map("n", "<C-j>", ":KittyNavigateDown<CR>", opts)
map("n", "<C-k>", ":KittyNavigateUp<CR>", opts)
map("n", "<C-l>", ":KittyNavigateRight<CR>", opts)

-- Pane resizing
map("n", "<C-Up>", ":resize +5<CR>", opts)
map("n", "<C-Down>", ":resize -5<CR>", opts)
map("n", "<C-Left>", ":vertical resize -5<CR>", opts)
map("n", "<C-Right>", ":vertical resize +5<CR>", opts)
map("n", "<leader>=", "<C-w>=", opts)

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<Tab>", ":b#<CR>", opts)

-- Line move
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)

-- Easiser splits
map("n", "<leader><bar>", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>", opts)
map("n", "<leader>q", ":enew<bar>bd #<CR>", opts)
map("n", "<leader>Q", ":close<CR>", opts)

-- Clear search results on <F3>
map("n", "<F3>", ":noh<CR>", opts)

-- Quick open adjacent file
map("n", "<leader>la", ":e <C-R>=expand('%:h').\"/\"<CR>", { noremap = true })

-- Buffers
map("n", "<leader>bc", "<cmd>bd<CR>", opts) -- Close buffer
map("n", "<leader>bk", "<cmd>%bd|e#|bd#<CR>", opts);
map("n", "[b", "<cmd>BufferLineCyclePrev<CR>", opts)
map("n", "]b", "<cmd>BufferLineCycleNext<CR>", opts)

-- Easier mark jumping
map("n", "'", "`", {})

-- Safe paste
map("x", "sp", "\"_dP", opts)

-- Spelling correction
map("n", "<leader>zz", "1z=E", opts)

-- Block sorting
map("n", "<leader>m", "vi{:sort<CR>", opts)

-- LSP
M.lsp_keymaps = function(bufnr)
  bf_map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- bf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  bf_map(bufnr, "n", "gd", "<cmd>Trouble lsp_definitions<CR>", opts) -- Let Telescope list references
  bf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- bf_map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  bf_map(bufnr, "n", "gt", "<cmd>Trouble lsp_type_definitions<CR>", opts) -- Let Telescope list references
  bf_map(bufnr, "n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  --bf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- bf_map(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- Let Telescope list references
  bf_map(bufnr, "n", "gr", "<cmd>Trouble lsp_references<CR>", opts)

  bf_map(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  bf_map(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  bf_map(bufnr, "n", "[e",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>', opts)
  bf_map(bufnr, "n", "]e",
    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>', opts)
  bf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- bf_map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  bf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  bf_map(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  bf_map(bufnr, "n", "<leader>y", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  bf_map(bufnr, "n", "gy", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
  bf_map(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

-- Telescope
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
map("n", "<leader>ft", "<CMD>Telescope live_grep<CR>", opts)
map("n", "<leader>f;", "<CMD>Telescope buffers<CR>", opts)
map("n", "<leader>fg", "<CMD>Telescope git_status<CR>", opts)
map("n", "<leader>fb", "<CMD>Telescope git_branches<CR>", opts)
map("n", "<leader>fr", "<CMD>Telescope lsp_references<CR>", opts)
map("n", "<leader>fd", "<CMD>Telescope lsp_definitions<CR>", opts)
map("n", "<leader>fi", "<CMD>Telescope lsp_implementations<CR>", opts)
map("n", "<leader>fh", "<CMD>Telescope oldfiles<CR>", opts)

-- Tab navigation
map("n", "<leader>1", "1gt", opts)
map("n", "<leader>2", "1gt", opts)
map("n", "<leader>3", "1gt", opts)
map("n", "<leader>0", "<CMD>tablast<CR>", opts)

-- Diagnostics
map("n", "<leader>X", "<CMD>TroubleToggle workspace_diagnostics<CR>")

-- Comment toggling
M.commments = {
  toggleLine = "gcc",
  toggleBlock = "gcb",
  opLeaderLine = "gc",
  opLeaderBlock = "gb",
}

-- Nvimtree
map("n", "<leader>o", "<CMD>NvimTreeFindFileToggle<CR>", opts)
map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", opts)

-- Formatting
map("n", "<leader>p", "<cmd>lua vim.lsp.buf.format({timeout_ms = 5000, async = true})<CR>", opts)

-- Spectre search
map("n", "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", opts)
map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opts)
map("v", "<leader>sw", "<cmd>lua require('spectre').open_visual()<CR>", opts)
map("n", "<leader>sf", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", opts)


-- Git stuff
map("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", opts)
map("n", "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", opts)
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", opts)
map("n", "<leader>dr", "<cmd>DiffviewRefresh<CR>", opts)
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
map("n", "<leader>gc", "<cmd>:Neogit commit<CR>", opts)
map("n", "<leader>gr", "<cmd>:Neogit rebase<CR>", opts)
map("n", "<leader>gm", "<cmd>:Neogit merge<CR>", opts)
map("n", "<leader>gl", "<cmd>:Neogit log<CR>", opts)
map("n", "<leader>gv", "<cmd>:Neogit<CR>", opts)
map('n', "<leader>G", "<cmd>:LazyGit<CR>", opts)

M.gitsigns = function(gs, bufnr)
  --[[ bf_map(bufnr, 'n', ']h', function()
    if vim.wo.diff then return ']h' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { expr = true, noremap = true, silent = true })

  bf_map(bufnr, 'n', '[h', function()
    if vim.wo.diff then return '[h' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { expr = true, noremap = true, silent = true })
 ]]

  -- Navigation
  bf_map(bufnr, 'n', ']h', gs.next_hunk, opts);
  bf_map(bufnr, 'n', '[h', gs.prev_hunk, opts);

  -- Actions
  bf_map(bufnr, { 'n', 'v' }, '<leader>hs', gs.stage_hunk, opts)
  bf_map(bufnr, { 'n', 'v' }, '<leader>hr', gs.reset_hunk, opts)

  bf_map(bufnr, 'n', '<leader>hS', gs.stage_buffer, opts)
  bf_map(bufnr, 'n', '<leader>hu', gs.undo_stage_hunk, opts)
  bf_map(bufnr, 'n', '<leader>hR', gs.reset_buffer, opts)
  bf_map(bufnr, 'n', '<leader>hp', gs.preview_hunk, opts)
  bf_map(bufnr, 'n', '<leader>hb', function() gs.blame_line { full = true } end, opts)

  bf_map(bufnr, 'n', '<leader>tb', gs.toggle_current_line_blame, opts)
  bf_map(bufnr, 'n', '<leader>td', gs.toggle_deleted, opts)

  -- Text object
  bf_map(bufnr, { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
end

map('n', '<leader>co', '<Plug>(git-conflict-ours)', opts)
map('n', '<leader>ct', '<Plug>(git-conflict-theirs)', opts)
map('n', '<leader>cb', '<Plug>(git-conflict-both)', opts)
map('n', '<leader>c0', '<Plug>(git-conflict-none)', opts)
map('n', ']x', '<Plug>(git-conflict-prev-conflict)', opts)
map('n', '[x', '<Plug>(git-conflict-next-conflict)', opts)

-- Treesitter text object
M.treesitter_textobjects = {
  select = {
    -- You can use the capture groups defined in textobjects.scm
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    -- You can optionally set descriptions to the mappings (used in the desc parameter of
    -- nvim_buf_set_keymap) which plugins like which-key display
    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
    -- You can also use captures from other query groups like `locals.scm`
    ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },

    ["an"] = { query = "@comment.outer", desc = "Select outer part of a comment string" },
    ["in"] = { query = "@comment.inner", desc = "Select inner part of a comment string" },

    ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a function parameter" },
    ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a function parameter" },

    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

    ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
    ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

    ["av"] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
    ["iv"] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },

    ["va"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
    ["vv"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
  },
  swap = {
    swap_next = {
      ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
      ["<leader>A"] = "@parameter.inner",
    },
  },
  move = {
    goto_next_start = {
      ["]f"] = "@function.outer",
      ["]a"] = "@parameter.outer",
      ["]v"] = "@assignment.outer",
      ["]]"] = { query = "@class.outer", desc = "Next class start" },
      --
      -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
      -- ["]o"] = "@loop.*",
      -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
      --
      -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
      -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
      ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
      ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
    },
    goto_next_end = {
      ["]F"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[f"] = "@function.outer",
      ["[a"] = "@parameter.outer",
      ["[["] = "@class.outer",
      ["[v"] = "@assignment.outer",
    },
    goto_previous_end = {
      ["[F"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  }
}

return M
