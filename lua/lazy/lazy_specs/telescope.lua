return {
	{
		'nvim-telescope/telescope.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		tag = '0.1.8',
		lazy = false,

		config = function()
			vim.g.mapleader = " "
			require('telescope').load_extension('fzf')
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files)
			vim.keymap.set("n", "<Leader>fh", require("telescope.builtin").help_tags)
		end
	}
}
