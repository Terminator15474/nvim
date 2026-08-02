vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {})


vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev) 
		local spec = ev.data.spec
		-- currently not needed, but a way to run "build" command of lazy.nvim
		-- if spec.name == 'fzf-native.nvim' and (ev.data.kind == 'install' or ev.data.kind == 'update' ) then
		-- 	vim.system(
		-- 		{'make'},
		-- 		{ cwd = ev.data.path, }
		-- 	):wait()
		-- end

		require('nvim-treesitter.install').update() 
	end
})



-- Color Scheme
vim.pack.add({
	'https://github.com/folke/tokyonight.nvim',
})

require('plugin_config.tokyonight')


-- Treesitter
vim.pack.add({
	'https://github.com/nvim-treesitter/nvim-treesitter',
})

require('plugin_config.treesitter')


-- Completion
vim.pack.add({
	'https://github.com/xzbdmw/colorful-menu.nvim',
	'https://github.com/saghen/blink.lib',
	'https://github.com/saghen/blink.cmp',
})

require('plugin_config.completion')


-- LSP
vim.pack.add({
	'https://github.com/gonstoll/wezterm-types', -- maybe unneeded
	'https://github.com/folke/lazydev.nvim',
	'https://github.com/williamboman/mason.nvim',
	'https://github.com/williamboman/mason-lspconfig.nvim',
	'https://github.com/saghen/blink.cmp',
	'https://github.com/williamboman/mason.nvim',
	'https://github.com/neovim/nvim-lspconfig',
})

require('plugin_config.lsp') -- requires blink.cmp


----------------------
-- NOT AS IMPORTANT --
----------------------


-- Debugger
vim.pack.add({
	'https://github.com/rcarriga/nvim-dap-ui',
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/nvim-neotest/nvim-nio',
})

require('plugin_config.debugger')


-- Common dependencies
vim.pack.add({
	'https://github.com/nvim-tree/nvim-web-devicons',
})


-- Fzf Lua
vim.pack.add({
	'https://github.com/ibhagwan/fzf-lua',
})

require('plugin_config.fzf_lua')


-- lualine
vim.pack.add({
	'https://github.com/nvim-lualine/lualine.nvim',
})

require('plugin_config.lualine')


-- Breadcrumbs
vim.pack.add({
	'https://github.com/SmiteshP/nvim-navic',
	'https://github.com/LunarVim/breadcrumbs.nvim',
})

require('plugin_config.breadcrumbs')


-- Neotree
vim.pack.add({
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/MunifTanjim/nui.nvim',
	{ src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range('3') },
})


-- Snacks
vim.pack.add({
	'https://github.com/folke/snacks.nvim',
})

require('plugin_config.snacks')


-- Gitsigns
vim.pack.add({
	'https://github.com/lewis6991/gitsigns.nvim',
})

require('plugin_config.gitsigns')
