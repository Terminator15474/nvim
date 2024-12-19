return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			{
				'nvim-lua/plenary.nvim'
			},
			{
				'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
			},
		},
		config = function()
			require('telescope').load_extension('fzf')
			require("telescope").setup {
				extensions = {
					fzf = {}
				}
			}
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		end,
	}
}
