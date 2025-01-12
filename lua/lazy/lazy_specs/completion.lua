return {
	{
		"xzbdmw/colorful-menu.nvim",
		config = function()
			-- You don't need to set these options.
			require("colorful-menu").setup({
				ls = {
					lua_ls = {
						-- Maybe you want to dim arguments a bit.
						arguments_hl = "@comment",
					},
					gopls = {
						-- When true, label for field and variable will format like "foo: Foo"
						-- instead of go's original syntax "foo Foo".
						add_colon_before_type = false,
					},
					["rust-analyzer"] = {
						-- Such as (as Iterator), (use std::io).
						extra_info_hl = "@comment",
					},
					-- If true, try to highlight "not supported" languages.
					fallback = true,
				},
				-- If the built-in logic fails to find a suitable highlight group,
				-- this highlight is applied to the label.
				fallback_highlight = "@variable",
				-- If provided, the plugin truncates the final displayed text to
				-- this width (measured in display cells). Any highlights that extend
				-- beyond the truncation point are ignored. Default 60.
				max_width = 60,
			})
		end,
		lazy = false,
		priotity = 1000
	},
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',
		version = 'v0.9.2',

		config = function()
			---@type blink.cmp.Config
			local opts = {
				keymap = {
					preset = 'super-tab',
					['<UP>'] = { 'select_prev', 'fallback' },
					['<DOWN>'] = { 'select_next', 'fallback' },
					['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
					['<PageUp>'] = { 'scroll_documentation_up' },
					['<PageDown>'] = { 'scroll_documentation_down' }
				},
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = 'mono',
				},
				sources = {
					default = { 'lsp', 'lazydev', 'path', 'buffer' },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},
				completion = {
					accept = { auto_brackets = { enabled = true } },
					trigger = {
						prefetch_on_insert = true,
					},
					menu = {
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = require("colorful-menu").blink_completion_text,
									highlight = require("colorful-menu").blink_completion_highlight,
								},
							},
							treesitter = {
								'lsp',
							}
						}
					},
					documentation = {
						auto_show = true,
						-- Delay before showing the documentation window
						auto_show_delay_ms = 100,
						-- Delay before updating the documentation window when selecting a new item,
						-- while an existing item is still visible
						update_delay_ms = 50,
						-- Whether to use treesitter highlighting, disable if you run into performance issues
						treesitter_highlighting = true,
						window = {
							min_width = 10,
							max_width = 80,
							max_height = 25,
							border = 'padded',
							winblend = 0,
							winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
							-- Note that the gutter will be disabled when border ~= 'none'
							scrollbar = true,
							-- Which directions to show the documentation window,
							-- for each of the possible menu window directions,
							-- falling back to the next direction when there's not enough space
							direction_priority = {
								menu_north = { 'e', 'w', 'n', 's' },
								menu_south = { 'e', 'w', 's', 'n' },
							},
						},
					}
				},
				signature = { enabled = true, },
			}

			require("blink.cmp").setup(opts)
		end
	},
	{
		'echasnovski/mini.pairs',
		version = '*',
		config = function()
			require('mini.pairs').setup {
				-- In which modes mappings from this `config` should be created
				modes = { insert = true, command = false, terminal = false },

				-- Global mappings. Each right hand side should be a pair information, a
				-- table with at least these fields (see more in |MiniPairs.map|):
				-- - <action> - one of 'open', 'close', 'closeopen'.
				-- - <pair> - two character string for pair to be used.
				-- By default pair is not inserted after `\`, quotes are not recognized by
				-- `<CR>`, `'` does not insert pair after a letter.
				-- Only parts of tables can be tweaked (others will use these defaults).
				mappings = {
					['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
					['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
					['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
					['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },

					[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
					[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
					['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
					['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },

					['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
					["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
					['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
				},
			}
		end
	},
}
