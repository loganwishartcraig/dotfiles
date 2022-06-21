local M = {}

-- Bootstrap packer install on new machines
M.bootstrap = function() 
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	end
end

-- Default configruration
M.config = {
	display = {
		open_fn = require('packer.util').float,
	}
}

-- Called to register plugins
M.run = function(plugins) 

	local packer = require('packer')

	packer.startup(function(use) 
		for _, v in pairs(plugins) do
			use(v)
		end
	end)
end

return M
