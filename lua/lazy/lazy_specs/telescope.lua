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
			{
				'jvgrootveld/telescope-zoxide'
			}

		},
		config = function()
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('zoxide')

			require("telescope").setup {
				extensions = {
					fzf = {},
					zoxide = {
						prompt_title = "[ Zoxide ]",
					}
				}
			}
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader>ft", builtin.live_grep)
			vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list)
		end,
	}
}
