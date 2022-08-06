local M = {}
local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap
local bf_map = vim.api.nvim_buf_set_keymap

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
map("n", "<leader>q", ":close<CR>", opts)

-- Clear search results on <F3>
map("n", "<F3>", ":noh<CR>", opts)

-- Quick open adjacent file
map("n", "<leader>la", ":e <C-R>=expand('%:h').\"/\"<CR>", { noremap = true })

-- Quick close buffer
map("n", "<leader>c", ":bd<CR>", opts)

-- Easier mark jumping
map("n", "'", "`", {})

-- Safe paste
map("x", "sp", "\"_dP", opts)

-- Spelling correction
map("n", "<leader>zz", "1z=E", opts)

-- LSP
M.lsp_keymaps = function(bufnr)
  bf_map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  bf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  bf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  --bf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  bf_map(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- Let Telescope list references

  bf_map(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  bf_map(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  bf_map(bufnr, "n", "[e",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>', opts)
  bf_map(bufnr, "n", "]e",
    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = vim.diagnostic.severity.ERROR })<CR>', opts)
  bf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- bf_map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  bf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  bf_map(bufnr, "n", "<leader>y", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  bf_map(bufnr, "n", "gy", '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>', opts)
  bf_map(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

-- Telescope
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
map("n", "<leader>ft", "<CMD>Telescope live_grep<CR>", opts)
map("n", "<leader>f;", "<CMD>Telescope buffers<CR>", opts)
map("n", "<leader>fg", "<CMD>Telescope git_branches<CR>", opts)
map("n", "<leader>fr", "<CMD>Telescope lsp_references<CR>", opts)
map("n", "<leader>fd", "<CMD>Telescope lsp_definitions<CR>", opts)
map("n", "<leader>fi", "<CMD>Telescope lsp_implementations<CR>", opts)

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
map("n", "<leader>p", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

return M
