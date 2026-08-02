

require('telescope').setup {
	extensions = {
		fzf = {},
	}
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')

-- Text Options
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>ft', builtin.live_grep)

-- Nvim Options
vim.keymap.set('n', '<leader>fn', function()
	builtin.find_files {
		cwd = vim.fn.stdpath('config')
	}
end)

-- Colors
vim.keymap.set('n', '<leader>cc', builtin.colorscheme)

-- Git
vim.keymap.set('n', '<leader>gc', builtin.git_bcommits) -- Shows commits of current file
vim.keymap.set('n', '<leader>gb', builtin.git_branches) -- Shows branches
