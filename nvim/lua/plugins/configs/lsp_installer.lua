local options = {
	automatic_installation = true,
	max_concurrent_installers = 50,
}

require("nvim-lsp-installer").setup(options)
