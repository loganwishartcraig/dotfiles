local options = {
  backup = false,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showcmd = false,
  showmode = false,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 250,
  ttimeoutlen = 50,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  cursorline = true,
  number = true,
  relativenumber = false,
  numberwidth = 2,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 10,
  sidescrolloff = 10,
  guifont = "monospace:h17",
  title = true,
  titlestring = "%t - nvim",
  spell = true,
  spelllang = "en",
  spelloptions = "camel,noplainbuffer",
  -- Ensures folds are always open
  foldlevel = 300,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()"
e

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

-- Plugin options
vim.g.kitty_navigator_no_mappings = 1
vim.g.kitty_navigator_password = 'cavity-guiding-stereo-volley'
vim.g.camelcasemotion_key = '<leader>'
