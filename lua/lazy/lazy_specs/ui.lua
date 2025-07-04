return {
	(function()
		local dir = "C:/Users/jando/AppData/Local/nvim/custom_plugins/random_colors"

		if vim.loop.os_uname().sysname == "Linux" then
			dir = "~/.config/nvim/custom_plugins/random_colors/"
		end

		local ret = {
			dir = dir,
			dependencies = {
				'shaunsingh/nord.nvim',
				'ficcdaf/ashen.nvim',
				"rebelot/kanagawa.nvim",
				"rose-pine/neovim",
				"0xstepit/flow.nvim",
			},
			cmd = "RandomColors",
		}

		return ret
	end)(),
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		version = '*',
		lazy = false,
		--event = { "VimEnter" },
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
		opts = {
			function()
				return require("lazydo").get_lualine_stats() -- status
			end,
			cond = function()
				return require("lazydo")._initialized -- condition for lualine
			end,

			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		}
	},
	{
		"LunarVim/breadcrumbs.nvim",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-navic").setup {
				lsp = {
					auto_attach = true,
				}
			}

			require("breadcrumbs").setup()
		end,
	},
	{
		'xiyaowong/transparent.nvim',
		lazy=false,
		-- cmd = "TransparentToggle",
		config = function()
			require("transparent").setup({
				-- table: default groups
				groups = {
					'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
					'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
					'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
					'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
					'EndOfBuffer',
				},
				-- table: additional groups that should be cleared
				extra_groups = {},
				-- table: groups you don't want to clear
				exclude_groups = {},
				-- function: code to be executed after highlight groups are cleared
				-- Also the user event "TransparentClear" will be triggered
				on_clear = function() end,
			})
		end
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		cmd = "ToggleTerm",
		keys = { "<leader>tt" },
		opts = {
			open_mapping = [[<leader>tt]],
		},
	},
	{
		'Dan7h3x/LazyDo',
		branch = "main",
		cmd = { "LazyDoToggle", "LazyDoPin" },
		keys = {
			{
				"<leader>ts", "<ESC><CMD>LazyDoToggle<CR>", mode = { "n" }
			}
		},
		opts = {}
		--	event = "VeryLazy",
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
			vim.cmd.colors("tokyonight")
		end
	},
	{
		"0xstepit/flow.nvim",
		tag = "v2.0.0",
		-- @module 0xstepit/flow.nvim
		-- @type
		opts = {
			theme = {
				transparent = false,
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
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {
			compile = true,
			transparent = false,
			terminalColors = true,
		}
	},
	{
		'shaunsingh/nord.nvim',
	},
	{
		'ficcdaf/ashen.nvim'
	}
}
