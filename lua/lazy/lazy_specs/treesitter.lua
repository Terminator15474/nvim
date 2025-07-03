return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"OXY2DEV/markview.nvim",
	},

	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"vimdoc", "javascript", "typescript", "c", "lua", "rust",
				"jsdoc", "bash",
			},
			ignore_install = { "tex" },

			sync_install = false,
			auto_install = true,
			indent = {
				enable = true
			},

			highlight = {
				-- `false` will disable the whole extension
				enable = true,
				disable = function(lang, buf)
					if lang == "html" or lang == "tex" then
						vim.notify_once("Disabled Treesitter because file is of type" .. lang)
						return true
					end

					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						vim.notify(
							"File larger than 100KB treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
						return true
					end
				end,
				additional_vim_regex_highlighting = { "markdown" },
			},
			modules = {},
		})

		local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		---@diagnostic disable-next-line: inject-field
		treesitter_parser_config.templ = {
			install_info = {
				url = "https://github.com/vrischmann/tree-sitter-templ.git",
				files = { "src/parser.c", "src/scanner.c" },
				branch = "master",
			},
		}
		vim.treesitter.language.register("templ", "templ")
	end
}
