return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>ff", function()
				builtin.find_files()
			end)

			vim.keymap.set("n", "<Leader>fh", function()
				builtin.help_tags()
			end)
		end
	}
}
