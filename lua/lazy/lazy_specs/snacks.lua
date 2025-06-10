return {
	"folke/snacks.nvim",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	priority = 1000,
	lazy = false,
	---@modulle folke.snacks.nvim
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 10000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			}
		},
		profiler = {
			enabled = vim.env.PROF,
		}
	},
	keys = {
		{ "<leader>ps", function() Snacks.profiler.scratch() end,      desc = "Profiler scratch buffer" },
		{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
		{ "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse",               mode = { "n", "v" } },
		{ "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		}
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.diagnostics():map("<leader>td")
				Snacks.toggle.profiler():map("<leader>pp")
			end,
		})
	end,
}
