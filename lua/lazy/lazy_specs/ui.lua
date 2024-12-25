return {
	{
		'echasnovski/mini.statusline',
		version = '*',
		config = function()
			require('mini.statusline').setup {
				content = {
					active = nil,
					inactive = nil
				},
				use_icons = true,
				set_vim_settings = true,
			}
		end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = 'moon',
			transparent = false,

		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd [[ colorscheme tokyonight ]]
		end
	},
	{
		"0xstepit/flow.nvim",
		lazy = false,
		priority = 1000,
		tag = "v2.0.0",
		-- @module 0xstepit/flow.nvim
		-- @type
		opts = {
			theme = {
				transparent = true,
				style = "dark", --  "dark" | "light"
				contrast = "default", -- "default" | "high"
			},
			colors = {
				mode = "default", -- "default" | "dark" | "light"
				fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
			},
			ui = {
				borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
				aggressive_spell = false, -- true | false
			},
		},
	},
}
