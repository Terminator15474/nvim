return {
	{
		'nvzone/typr',
		cmd = { "TyprStats", "Typr" },
		dependencies = "nvzone/volt",
		opts = {},
	},
	{
		'https://github.com/dstein64/vim-startuptime',
		lazy = false,
		enabled = false,
	},
	{
		'OXY2DEV/markview.nvim',
		lazy = false,
		priority = 49,
		dependencies = {
			"saghen/blink.cmp",
		}
	},
	{
		'ThePrimeagen/vim-be-good',
		lazy = true,
		cmd = "VimBeGood",
	}
}
