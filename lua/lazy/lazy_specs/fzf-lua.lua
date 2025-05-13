return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true }, -- Optional, for icons
		},
		keys = {
			"<leader>fh", "<leader>ff", "<leader>ft",
			"<leader>cc", "<leader>fn", "<leader>gc",
			"<leader>gb", "<leader>cd"
		},
		config = function()
			local fzf = require("fzf-lua")

			fzf.setup({
				"telescope", -- Use Telescope-like theme
				winopts = {
					preview = {
						hidden = "nohidden",
					},
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>ff", function()
				fzf.git_files({ cwd = vim.fn.getcwd(), hidden = true, ignore_current_file = true })
			end)

			-- mnemonic -> _F_ind _A_ll files
			vim.keymap.set("n", "<leader>fa", function()
				fzf.files { cwd = vim.fn.getcwd(), ignore_current_file = true, no_ignore = true }
			end)

			vim.keymap.set("n", "<leader>fh", fzf.help_tags)
			vim.keymap.set("n", "<leader>ft", fzf.live_grep)

			vim.keymap.set("n", "<leader>fn", function()
				fzf.git_files({ cwd = vim.fn.stdpath("config"), hidden=true, ignore_current_file=true})
			end)

			vim.keymap.set("n", "<leader>cc", fzf.colorschemes)
			vim.keymap.set("n", "<leader>gc", fzf.git_bcommits)
			vim.keymap.set("n", "<leader>gb", fzf.git_branches)

			-- Optional: Use zoxide with fzf-lua if desired
			vim.keymap.set("n", "<leader>cd", fzf.zoxide) -- Only works if zoxide is installed
		end,
	}
}
