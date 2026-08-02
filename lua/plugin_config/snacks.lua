local opts = {
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
}

require('snacks').setup(opts)
